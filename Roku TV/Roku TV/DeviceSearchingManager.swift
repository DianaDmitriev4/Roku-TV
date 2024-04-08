//
//  DeviceSearchingManager.swift
//  Roku TV
//
//  Created by User on 04.04.2024.
//

import Foundation
import Network

protocol BrowserDelegate: AnyObject {
    func refreshResults(results: Set<NWBrowser.Result>)
}

final class DeviceSearchingManager: NSObject {
    // MARK: - Properties
    var browser: NWBrowser?
    weak var delegate: BrowserDelegate?
    
    
    init(delegate: BrowserDelegate) {
        self.delegate = delegate
    }
    // MARK: - Methods
    func startSearching(){
        let parameters = NWParameters()
        parameters.includePeerToPeer = true
        
        let browser = NWBrowser(for: .bonjour(type: "_http._tcp.", domain: nil), using: parameters)
        self.browser = browser
        
        browser.browseResultsChangedHandler = { newResult, changes in
            self.delegate?.refreshResults(results: newResult)
        }
        
        browser.stateUpdateHandler = { newState in
            switch newState {
            case .failed(let error):
                if error == NWError.dns(DNSServiceErrorType(kDNSServiceErr_DefunctConnection)) {
                    print("Browser failed with \(error), restarting")
                    browser.cancel()
                    self.startSearching()
                } else {
                    print("Browser failed with \(error), stopping")
                    browser.cancel()
                }
            case .ready:
                print("Browser is ready")
                self.delegate?.refreshResults(results: browser.browseResults)
            case .cancelled:
                self.delegate?.refreshResults(results: Set())
            default:
                break
            }
        }
        
        browser.start(queue: .main)
    }
}
