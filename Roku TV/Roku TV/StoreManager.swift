//
//  StoreManager.swift
//  Roku TV
//
//  Created by User on 07.04.2024.
//

import SwiftyStoreKit
import Foundation

enum ProductID: Int, CaseIterable {
    case Monthly = 1, Weekly, Yearly
    
    var identifier: String {
        switch self {
        case .Monthly:
            "monthly"
        case .Weekly:
            "weekly"
        case .Yearly:
            "yearly"
        }
    }
}

final class StoreManager {
    // Complete Transactions. Called every time the application is launched
    static func completeTransactions() {
        DispatchQueue.global().async {
            SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
                purchases.forEach { purchase in
                    switch purchase.transaction.transactionState {
                    case .purchased, .restored:
                        if purchase.needsFinishTransaction {
                            SwiftyStoreKit.finishTransaction(purchase.transaction)
                        }
                    default:
                        break
                    }
                }
            }
        }
    }
    
    // Purchase product
    static func purchaseProduct(completion: @escaping (Bool) -> Void, productId: String) {
        SwiftyStoreKit.purchaseProduct(productId) { result in
            switch result {
            case .success(purchase: let purchase):
                print("Purchase Success: \(purchase.productId)")
                completion(true)
                
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default: print((error as NSError).localizedDescription)
                    completion(false)
                }
            default:
                break
            }
        }
    }
    
    static func verifySubscription(completion: @escaping (Bool) -> Void) {
#if DEBUG
        let certificate = "StoreKitTestCertificate"
#else
        let certificate = "AppleIncRootCertificate"
#endif
        let appleValidator = AppleReceiptValidator(service: .sandbox)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let productCase = ProductID.allCases
                let productID = productCase.map { $0.identifier }
                let productIds = Set(productID)
                let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: productIds, inReceipt: receipt)
                switch purchaseResult {
                case .purchased(let expiryDate, let items):
                    print("\(productIds) are valid until \(expiryDate)\n\(items)\n")
                    completion(true)
                case .expired(let expiryDate, let items):
                    print("\(productIds) are expired since \(expiryDate)\n\(items)\n")
                case .notPurchased:
                    print("The user has never purchased \(productIds)")
                    completion(false)
                }
            case .error(let error):
                print("Receipt verification failed: \(error)")
                completion(false)
            }
        }
    }
}
