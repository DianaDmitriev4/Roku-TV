//
//  AppCoordinator.swift
//  Roku TV
//
//  Created by User on 31.03.2024.
//

import UIKit
class AppCoordinator: Coordinator {
    // MARK: - Properties
    let navigationController: UINavigationController
    
    // MARK: - Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        showLaunchVC()
    }
    
    func showLastVC() {
        let vc = LastViewController()
        vc.viewModel = LaunchViewModel()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showContainerVC(viewController: UIViewController) {
        let vc = ContainerViewController()
        vc.modalPresentationStyle = .fullScreen
        viewController.present(vc, animated: true)
    }
    
    func showAppsVC(viewController: UIViewController) {
        let vc = AppsViewController()
        vc.coordinator = self
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .overFullScreen
        viewController.present(navController, animated: true)
    }
    
    func showNetworkVC(viewController: UIViewController) {
        let vc = NetworkTestViewController()
        vc.viewModel = NetworkTestViewModel()
        vc.coordinator = self
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .overFullScreen
        viewController.present(navController, animated: true)
    }
    
    func showMenuVC(viewController: UIViewController) {
        let vc = MenuViewController(viewModel: MenuViewModel())
        vc.coordinator = self
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showSelectDeviceVC(viewController: UIViewController) {
        let vc = SelectDeviceViewController()
        vc.viewModel = SelectDeviceViewModel()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showNetworkHistory(viewController: UIViewController) {
        let vc = NetworkHistoryViewController()
        vc.viewModel = NetworkTestViewModel()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Private methods
    private func  showLaunchVC() {
        let vc = LaunchViewController(viewModel: LaunchViewModel())
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
