//
//  AppDelegate.swift
//  Roku TV
//
//  Created by User on 21.03.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window {
//            window.rootViewController = LaunchViewController(viewModel: LaunchViewModel())
//            window.rootViewController = UINavigationController(rootViewController: ContainerViewController())
            window.rootViewController = ContainerViewController()
            window.makeKeyAndVisible()
        }
        return true
    }
}
