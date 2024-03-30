//
//  ContainerViewController.swift
//  Roku TV
//
//  Created by User on 24.03.2024.
//

import UIKit

final class ContainerViewController: UIViewController {
    // MARK: - Properties
    private var isMenuMove = false
    private var isSelectDeviceMove = false
    private var homeVC: HomeViewController?
    private var menuVC: MenuViewController?
    private var selectDeviceVC: SelectDeviceViewController?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHomeVC()
    }
}

// MARK: - Private methods
extension ContainerViewController {
    func configureHomeVC() {
        homeVC = HomeViewController(viewModel: HomeViewModel())
        if let homeVC {
            let navController = UINavigationController(rootViewController: homeVC)
            navController.view.frame = view.bounds
            homeVC.delegate = self
            addChild(navController)
            view.addSubview(navController.view)
            navController.didMove(toParent: self)
        }
    }
    
    func configureMenuVC() {
        menuVC = MenuViewController(viewModel: MenuViewModel())
        if let menuVC {
            menuVC.delegate = self
            menuVC.menuDelegate = homeVC
            addChild(menuVC)
            view.insertSubview(menuVC.view, at: 0)
            menuVC.didMove(toParent: self)
        }
    }
    
    func configureSelectDeviceVC() {
        selectDeviceVC = SelectDeviceViewController(viewModel: SelectDeviceViewModel())
        if let selectDeviceVC {
            selectDeviceVC.delegate = self
            addChild(selectDeviceVC)
            view.insertSubview(selectDeviceVC.view, at: 0)
            selectDeviceVC.didMove(toParent: self)
        }
    }
    
    func showMenu() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
            self?.homeVC?.navigationController?.view.frame.origin.x = (self?.homeVC?.view.frame.width ?? 0) - 81
        })
    }
    
    func hideMenu() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
            self?.homeVC?.navigationController?.view.frame.origin.x = 0
        }) { [weak self] _ in
            self?.menuVC?.willMove(toParent: nil)
            self?.menuVC?.view.removeFromSuperview()
            self?.menuVC?.removeFromParent()
        }
    }
    
    func showSelectDevice() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
            self?.homeVC?.navigationController?.view.frame.origin.x = -(self?.homeVC?.view.frame.width ?? 0) + 81
        })
    }
    
    func hideSelectDevice() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
            self?.homeVC?.navigationController?.view.frame.origin.x = 0
        }) { [weak self] _ in
            self?.selectDeviceVC?.willMove(toParent: nil)
            self?.selectDeviceVC?.view.removeFromSuperview()
            self?.selectDeviceVC?.removeFromParent()
        }
    }
}

// MARK: - HomeDelegate
extension ContainerViewController: HomeDelegate {
    func toggleLeftMenu() {
        if !isMenuMove {
            configureMenuVC()
        }
        isMenuMove = true
        showMenu()
    }
    
    func toggleRightMenu() {
        if !isSelectDeviceMove {
            configureSelectDeviceVC()
        }
        isSelectDeviceMove = true
        showSelectDevice()
    }
    
    func hideLeftMenu() {
        isMenuMove.toggle()
        hideMenu()
    }
    
    func hideRightMenu() {
        isSelectDeviceMove.toggle()
        hideSelectDevice()
    }
}
