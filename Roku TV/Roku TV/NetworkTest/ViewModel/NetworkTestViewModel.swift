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
    
    
}
