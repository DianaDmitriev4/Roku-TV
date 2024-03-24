//
//  HomeViewModel.swift
//  Roku TV
//
//  Created by User on 24.03.2024.
//

import UIKit

protocol HomeViewModelProtocol {
    var arrow: Dynamic<UIImage> { get set }
    var settingViewColor: Dynamic<UIColor> { get set }
    
    func openMenu(_ view: UIView)
    func hideMenu(_ view: UIView)
}

final class HomeViewModel: HomeViewModelProtocol {
    var arrow = Dynamic(UIImage())
    var settingViewColor = Dynamic(UIColor.specialGray)
    
    func openMenu(_ view: UIView) {
        view.isHidden = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.arrow.value = UIImage(named: "upArrow") ?? .back
            self?.settingViewColor.value = .specialViolet
        }
    }
    
    func hideMenu(_ view: UIView) {
        view.isHidden = true
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.arrow.value = UIImage(named: "downArrow") ?? .back
            self?.settingViewColor.value = .specialGray
        }
    }
}
