//
//  UIStackView + Extens.swift
//  Roku TV
//
//  Created by User on 21.03.2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ view: [UIView]) {
        view.forEach { view in
            addArrangedSubview(view)
        }
    }
}
