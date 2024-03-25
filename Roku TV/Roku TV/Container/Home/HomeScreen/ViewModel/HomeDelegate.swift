//
//  HomeDelegate.swift
//  Roku TV
//
//  Created by User on 24.03.2024.
//

import Foundation

protocol HomeDelegate: AnyObject {
    func toggleLeftMenu()
    func toggleRightMenu()
    func hideLeftMenu()
    func hideRightMenu()
}
