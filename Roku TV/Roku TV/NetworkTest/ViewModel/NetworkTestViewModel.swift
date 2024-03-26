//
//  NetworkTestViewModel.swift
//  Roku TV
//
//  Created by User on 26.03.2024.
//

import Foundation

protocol NetworkTestViewModelProtocol {
    var test: [NetworkTestModel]  { get set }
}

final class NetworkTestViewModel: NetworkTestViewModelProtocol {
    var test: [NetworkTestModel] = []
    
    init() {
        fillArrayWithModel()
    }
    
    private func fillArrayWithModel() {
        test = [NetworkTestModel(download: 25.2, upload: 25.2),
                NetworkTestModel(download: 25.2, upload: 25.2),
                NetworkTestModel(download: 25.2, upload: 25.2),
                NetworkTestModel(download: 25.2, upload: 25.2)
        ]
    }
}
