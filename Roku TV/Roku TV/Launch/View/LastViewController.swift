//
//  LastViewController.swift
//  Roku TV
//
//  Created by User on 22.03.2024.
//

import UIKit

final class LastViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var vectorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vector")
        return imageView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "last")
        return imageView
    }()
    
    private lazy var titleLabel = makeLabel(font: .boldSystemFont(ofSize: 27), textColor: .white, isUnderlined: false, text: "TV Remote\nwith no limitations")
    private lazy var descriptionLabel = makeLabel(font: .systemFont(ofSize: 14), textColor: .specialLightGrey, isUnderlined: false, text: "Control your TV from phone & test internet speed easily")
    
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
    
    private lazy var firstLabel = makeLabel(font: .systemFont(ofSize: 12), textColor: .specialMediumGrey, isUnderlined: true, text: "Terms of Use")
    private lazy var secondLabel = makeLabel(font: .systemFont(ofSize: 12), textColor: .specialMediumGrey, isUnderlined: true, text: "Privacy Policy")
    private lazy var thirdLabel = makeLabel(font: .systemFont(ofSize: 12), textColor: .specialMediumGrey, isUnderlined: true, text: "Restore Purchases")
    private lazy var fourthLabel = makeLabel(font: .systemFont(ofSize: 12), textColor: .specialMediumGrey, isUnderlined: true, text: "Not now")
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @objc private func goNextVC() {
        
    }
    
    private func makeGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.specialViolet.cgColor, UIColor.specialGrey.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupUI() {
        view.addSubviews([vectorImageView, imageView, titleLabel, descriptionLabel, continueButton, labelContainerView])
        labelContainerView.addSubviews([firstLabel, secondLabel, thirdLabel, fourthLabel])
        
        navigationItem.setHidesBackButton(true, animated: false)
        makeGradient()
        makeConstraints()
    }
    
    private func makeConstraints() {
        vectorImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(70)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(100)
        }
    }
    
    private func makeView(backgroundColor: UIColor, borderColor: UIColor, cornerRadius: CGFloat) -> UIView {
        let view = UIView()
        
        view.backgroundColor = backgroundColor
        view.layer.borderWidth = 2
        view.layer.borderColor = borderColor.cgColor
        view.layer.cornerRadius = cornerRadius
        
        return view
    }
    
    private func makeLabel(font: UIFont, textColor: UIColor, isUnderlined: Bool, text: String) -> UILabel {
        let label = UILabel()
        
        label.font = font
        label.textColor = textColor
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        
        if isUnderlined {
            let attributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                             .underlineColor: UIColor.specialMediumGrey]
            label.attributedText = NSAttributedString(string: label.text ?? "", attributes: attributes)
        }
        return label
    }
}
