//
//  HomeViewModel.swift
//  Roku TV
//
//  Created by User on 25.03.2024.
//

import UIKit

protocol HomeViewModelProtocol {
    var homeImage: Dynamic<UIImage> { get set }
    
    func changeImageToTouchpad()
    func changeImageToRemote()
}

final class HomeViewModel: HomeViewModelProtocol {
    var homeImage = Dynamic(UIImage())
    
    func changeImageToTouchpad() {
        homeImage.value = UIImage(named: "touchpadPanel") ?? .apps
    }
    
    func changeImageToRemote() {
        homeImage.value = UIImage(named: "home") ?? .apps
    }
}
