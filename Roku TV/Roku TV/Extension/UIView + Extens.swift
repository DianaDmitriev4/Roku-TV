//
//  UIView + Extens.swift
//  Roku TV
//
//  Created by User on 21.03.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
