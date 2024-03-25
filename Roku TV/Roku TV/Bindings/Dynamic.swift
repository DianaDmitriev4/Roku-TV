//
//  Dynamic.swift
//  Roku TV
//
//  Created by User on 24.03.2024.
//

import Foundation

final class Dynamic<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    var value: T {
        didSet {
       listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func binding(_ listener: Listener?) {
        self.listener = listener
    }
}
