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
        navigationController.pushViewController(vc, animated: true)
//        vc.modalPresentationStyle = .fullScreen
//        viewController.present(vc, animated: true)
    }
    
    func showAppsVC(viewController: UIViewController) {
        let vc = AppsViewController()
        vc.coordinator = self
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showNetworkVC() {
        let vc = NetworkTestViewController()
        vc.viewModel = NetworkTestViewModel()
        vc.coordinator = self
        vc.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showMenuVC() {
        let vc = MenuViewController()
        vc.coordinator = self
        vc.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showSelectDeviceVC() {
        let vc = SelectDeviceViewController()
//        vc.viewModel = SelectDeviceViewModel()
        vc.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showNetworkHistory() {
        let vc = NetworkHistoryViewController()
        vc.viewModel = NetworkTestViewModel()
        vc.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Private methods
    private func  showLaunchVC() {
        let vc = LaunchViewController(viewModel: LaunchViewModel())
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
