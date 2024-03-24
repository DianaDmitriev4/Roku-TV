//
//  ContainerViewController.swift
//  Roku TV
//
//  Created by User on 24.03.2024.
//

import UIKit

final class ContainerViewController: UIViewController {
    // MARK: - Properties
    private var isMove = false
    
    private var homeVC: HomeViewController?
    private var menuVC: MenuViewController?
    private var selectDeviceVC: SelectDeviceViewController?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHomeVC()
    }
    
    // MARK: - Private methods
    private func configureHomeVC() {
        homeVC = HomeViewController()
        if let homeVC {
            let nav = UINavigationController(rootViewController: homeVC) // TODO: УБРАТЬ НАВ БАР
            addVC(nav)
            homeVC.delegate = self
        }
    }
    
    private func configureMenuVC() {
        
            menuVC = MenuViewController(viewModel: MenuViewModel())
            //        addVC(menuVC)
        if let menuVC {
            addChild(menuVC)
            view.insertSubview(menuVC.view, at: 0)
            menuVC.didMove(toParent: self)
        }
    }
    
    private func configureSelectDeviceVC() {
        selectDeviceVC = SelectDeviceViewController(viewModel: SelectDeviceViewModel())
        addVC(selectDeviceVC)
    }
    
    private func showMenuVC(isHidden: Bool) {
        if isHidden {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: { [weak self] in
                self?.homeVC?.view.frame.origin.x = (self?.homeVC?.view.frame.width ?? 0) - 81
            }) { (finished) in
                
            }
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: { [weak self] in
                self?.homeVC?.view.frame.origin.x = 0
            }) { (finished) in
                self.remove()
            }
        }
    }
    
    private func addVC(_ child: UIViewController?) {
        if let child {
            addChild(child)
            view.addSubview(child.view)
            child.didMove(toParent: self)
        }
    }
    
    private func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

// MARK: - HomeDelegate
extension ContainerViewController: HomeDelegate {
    func toggleLeftMenu() {
        if !isMove {
            configureMenuVC()
            
        }
        isMove = !isMove
        showMenuVC(isHidden: isMove)
    }

func toggleRightMenu() {
    
}
}
