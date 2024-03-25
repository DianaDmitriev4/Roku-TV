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
        assignDelegate()
    }
    
    // MARK: - Private methods
    private func assignDelegate() {
        homeVC?.delegate = self
        menuVC?.delegate = self
        selectDeviceVC?.delegate = self
        menuVC?.menuDelegate = homeVC
        let appsVC = AppsViewController()
        appsVC.delegate = self
    }
    
    private func configureHomeVC() {
        homeVC = HomeViewController(viewModel: HomeViewModel())
        if let homeVC {
            let navController = UINavigationController(rootViewController: homeVC)
            navController.view.frame = view.bounds
//            homeVC.delegate = self
            addChild(navController)
            view.addSubview(navController.view)
            navController.didMove(toParent: self)
        }
    }
    
    private func configureMenuVC() {
        menuVC = MenuViewController(viewModel: MenuViewModel())
        if let menuVC {
//            let navController = UINavigationController(rootViewController: menuVC)
//            menuVC.delegate = self
            menuVC.menuDelegate = homeVC
            addChild(menuVC)
            view.insertSubview(menuVC.view, at: 0)
            menuVC.didMove(toParent: self)
        }
    }
    
    private func configureSelectDeviceVC() {
        selectDeviceVC = SelectDeviceViewController(viewModel: SelectDeviceViewModel())
        if let selectDeviceVC {
//            selectDeviceVC.delegate = self
            addChild(selectDeviceVC)
            view.insertSubview(selectDeviceVC.view, at: 0)
            selectDeviceVC.didMove(toParent: self)
        }
    }
    
    private func showMenu() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
            self?.homeVC?.navigationController?.view.frame.origin.x = (self?.homeVC?.view.frame.width ?? 0) - 81
        })
    }
    
    private func hideMenu() {
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
    
    private func showSelectDevice() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
            self?.homeVC?.navigationController?.view.frame.origin.x = -(self?.homeVC?.view.frame.width ?? 0) + 81
        })
    }
    
    private func hideSelectDevice() {
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
//                navigationController?.isNavigationBarHidden = true
            }
            isMenuMove = true
            showMenu()
        }
        
        func toggleRightMenu() {
            if !isSelectDeviceMove {
                configureSelectDeviceVC()
//                navigationController?.setNavigationBarHidden(true, animated: true)
            }
            isSelectDeviceMove = true
            showSelectDevice()
        }
        
        func hideLeftMenu() {
            isMenuMove.toggle()
            hideMenu()
//            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
        func hideRightMenu() {
            isSelectDeviceMove.toggle()
            hideSelectDevice()
//            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
