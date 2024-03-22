//
//  LastViewController.swift
//  Roku TV
//
//  Created by User on 22.03.2024.
//

import UIKit

final class LastViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        // TODO: - CHANGE CONSTRAINTS FOR IMAGEVIEW
        return imageView
    }()
    
    private lazy var vectorImageView: UIImageView = {
        let imageView = UIImageView()
        // TODO: - CHANGE CONSTRAINTS FOR IMAGEVIEW
        return imageView
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .specialViolet
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(goNextVC), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var labelContainerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeGradient()

    }
    
    @objc private func goNextVC() {
        
    }
    
    private func makeGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.specialViolet.cgColor, UIColor.specialGrey.cgColor]
        view.layer.addSublayer(gradientLayer)
    }
    
    private func setupUI() {
        navigationController?.navigationItem.hidesBackButton = true
        makeConstraints()
    }
    
    private func makeConstraints() {
        
    }
    
    private func makeLabel(font: UIFont, textColor: UIColor, isUnderlined: Bool) -> UILabel {
        let label = UILabel()
        
        label.font = font
        label.textColor = textColor
        label.text = "."
        label.numberOfLines = 0
        label.textAlignment = .center
        
        if isUnderlined {
            let attributes: [NSAttributedString.Key: Any] = [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
               .underlineColor: UIColor.specialMediumGrey
            ]
            label.attributedText = NSAttributedString(string: label.text ?? "", attributes: attributes)
        }
        
        return label
    }
}
