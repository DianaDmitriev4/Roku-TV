//
//  LaunchDetailViewController.swift
//  Roku TV
//
//  Created by User on 21.03.2024.
//

import UIKit

final class LaunchDetailViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        // TODO: - CHANGE CONSTRAINTS FOR IMAGEVIEW
        return imageView
    }()
    
    private lazy var titleLabel = makeLabel(font: .boldSystemFont(ofSize: 38), textColor: .specialViolet, isUnderlined: false)
    private lazy var descriptionLabel = makeLabel(font: .systemFont(ofSize: 14), textColor: .specialLightGrey, isUnderlined: false)
    
    private lazy var arrowImageView: UIImageView = {
        let image = UIImageView()
        
        image.backgroundColor = .specialGrey
        image.layer.cornerRadius = 22
        image.contentMode = .center
        image.image = UIImage(named: "arrowRight")
        
        return image
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
    
    private lazy var firstLabel = makeLabel(font: .systemFont(ofSize: 12), textColor: .lightGray, isUnderlined: true)
    private lazy var secondLabel = makeLabel(font: .systemFont(ofSize: 12), textColor: .lightGray, isUnderlined: true)
    private lazy var thirdLabel = makeLabel(font: .systemFont(ofSize: 12), textColor: .lightGray, isUnderlined: true)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Initialization
    init(source: LaunchModel){
        super.init(nibName: nil, bundle: nil)
        
        imageView.image = source.image
        titleLabel.text = source.title
        descriptionLabel.text = source.description
        continueButton.setTitle(source.buttonTitle, for: .normal)
        firstLabel.text = source.firstLabel
        secondLabel.text = source.secondLabel
        thirdLabel.text = source.thirdLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    @objc private func goNextVC() {
        guard let pageViewController = parent as? LaunchViewController else { return }
        pageViewController.goNext()
    }
    
    private func setupUI() {
        view.addSubviews([imageView, titleLabel, descriptionLabel, continueButton, labelContainerView])
        continueButton.addSubview(arrowImageView)
        labelContainerView.addSubviews([firstLabel, secondLabel, thirdLabel])
        makeConstraints()
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(481)
            make.leading.trailing.equalToSuperview().inset(45)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(45)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(47)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(15)
            make.width.height.equalTo(44)
        }
        
        labelContainerView.snp.makeConstraints { make in
            make.top.equalTo(continueButton.snp.bottom).offset(21)
            make.centerX.equalToSuperview()
        }
        
        firstLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        secondLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstLabel.snp.trailing).offset(15)
            make.top.equalToSuperview()
        }
        
        thirdLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(secondLabel.snp.trailing).offset(15)
            make.trailing.equalToSuperview()
        }
    }
    
    private func makeLabel(font: UIFont, textColor: UIColor, isUnderlined: Bool) -> UILabel {
        let label = UILabel()
        
        label.font = font
        label.textColor = textColor
        label.numberOfLines = 0
        label.textAlignment = .center
        
        if isUnderlined,
           let text = label.text {
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttributes([.underlineStyle: NSUnderlineStyle.single,
                                            .underlineColor: UIColor.specialMediumGrey], range: _NSRange(location: 0, length: attributedString.length))
            label.attributedText = attributedString
        }
        
        return label
    }
}
