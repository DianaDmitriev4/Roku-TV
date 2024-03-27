//
//  NetworkTestViewModel.swift
//  Roku TV
//
//  Created by User on 26.03.2024.
//

import SnapKit
import UIKit

//protocol NetworkTestViewModelProtocol {
//    var test: [NetworkTestModel]  { get set }
//}

final class NetworkTestViewModel: MenuViewModel {
    var test: [NetworkTestModel] = []
    var topConstraint: [UIView: Constraint] = [:]
    override init() {
        super.init()
        self.fillArrayWithModel()
    }
 
    private func fillArrayWithModel() {
        test = [NetworkTestModel(download: 25.2, upload: 25.2),
                NetworkTestModel(download: 25.2, upload: 25.2),
                NetworkTestModel(download: 25.2, upload: 25.2),
                NetworkTestModel(download: 25.2, upload: 25.2)
        ]
    }
}
