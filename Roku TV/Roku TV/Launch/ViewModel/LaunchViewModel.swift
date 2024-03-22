//
//  LaunchViewModel.swift
//  Roku TV
//
//  Created by User on 21.03.2024.
//

import UIKit

protocol LaunchViewModelProtocol {
    var sourceArray: [LaunchModel] { get }
}

final class LaunchViewModel: LaunchViewModelProtocol {
    // MARK: - Properties
    private(set) var sourceArray: [LaunchModel] = []
    
    init() {
        fillArrayWithData()
    }
    // MARK: - Private methods
    private func fillArrayWithData() {
        sourceArray = [
            LaunchModel(image: UIImage(named: "firstPage") ?? .checkmark,
                        title: "Remote Control for Roku TV",
                        description: "Use our convenient application instead of using remote control",
                        buttonTitle: "Continue",
                        firstLabel: "Terms of Use",
                        secondLabel: "Privacy Policy",
                        thirdLabel: nil),
            LaunchModel(image: UIImage(named: "secondPage") ?? .checkmark,
                        title: "Easy Device Connection",
                        description: "Connect to your devices via Wi-Fi and control TV with the place",
                        buttonTitle: "Continue",
                        firstLabel: "Terms of Use",
                        secondLabel: "Privacy Policy",
                        thirdLabel: nil),
            LaunchModel(image: UIImage(named: "thirdPage") ?? .checkmark,
                        title: "Your Favorites in One Place",
                        description: "Choose and watch your favorite channels, videos and movies",
                        buttonTitle: "Continue",
                        firstLabel: "Terms of Use",
                        secondLabel: "Privacy Policy",
                        thirdLabel: nil),
            LaunchModel(image: UIImage(named: "fourthPage") ?? .checkmark,
                        title: "Internet Speed Test",
                        description: "Use the diagnostic tool to analyze network signals",
                        buttonTitle: "Continue",
                        firstLabel: "Terms of Use",
                        secondLabel: "Privacy Policy",
                        thirdLabel: nil),
            LaunchModel(image: UIImage(named: "fifthPage") ?? .checkmark,
                        title: "Start to Continue TV Remote",
                        description: "Start to continue TV Reomote app with a 3-day trial and 499 rub/week",
                        buttonTitle: "Get free trial",
                        firstLabel: "Terms of Use",
                        secondLabel: "Privacy Policy",
                        thirdLabel: "Restore Purchases")
        ]
    }
}
