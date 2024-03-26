//
//  NetworkTestViewModel.swift
//  Roku TV
//
//  Created by User on 26.03.2024.
//

import UIKit

protocol NetworkTestViewModelProtocol {
    var test: [NetworkTestModel]  { get set }
}

final class NetworkTestViewModel: NetworkTestViewModelProtocol {
    var test: [NetworkTestModel] = []
    
    init() {
        fillArrayWithModel()
    }
    
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
    
    private func fillArrayWithModel() {
        test = [NetworkTestModel(download: 25.2, upload: 25.2),
                NetworkTestModel(download: 25.2, upload: 25.2),
                NetworkTestModel(download: 25.2, upload: 25.2),
                NetworkTestModel(download: 25.2, upload: 25.2)
        ]
    }
}
