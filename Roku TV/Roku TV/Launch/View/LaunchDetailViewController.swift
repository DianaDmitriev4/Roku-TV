//
//  LaunchDetailViewController.swift
//  Roku TV
//
//  Created by User on 21.03.2024.
//

import UIKit

final class LaunchDetailViewController: UIViewController {
    // MARK: - GUI Variables
    private var imageView = UIImageView()
    
    private lazy var titleLabel = makeLabel(font: .boldSystemFont(ofSize: 38), textColor: .specialViolet, isUnderlined: false)
    private lazy var descriptionLabel = makeLabel(font: .systemFont(ofSize: 14), textColor: .specialLightGray, isUnderlined: false)
    
    private var arrowImageView: UIImageView = {
        let image = UIImageView()
        
        image.backgroundColor = .specialGray
        image.contentMode = .center
        image.image = UIImage(named: "arrowRight")
        
        return image
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .specialViolet
        button.layer.cornerRadius = 16
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        arrowImageView.layer.cornerRadius = arrowImageView.frame.height / 2
    }
    
    // MARK: - Initialization
    init(source: LaunchModel) {
        super.init(nibName: nil, bundle: nil)
        
        imageView.image = source.image
        imageView.contentMode = .scaleToFill
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
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(65)
//            make.bottom.equalToSuperview().inset(308) //308 142
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        titleLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(481)
            make.top.equalTo(imageView.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(45)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.074) // 7,389 % of screen
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(15)
            make.width.equalTo(arrowImageView.snp.height)
        }
        
        labelContainerView.snp.makeConstraints { make in
            make.top.equalTo(continueButton.snp.bottom).offset(21)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        secondLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstLabel.snp.trailing).offset(15)
            make.top.bottom.equalToSuperview()
        }
        
        thirdLabel.snp.makeConstraints { make in
            make.leading.equalTo(secondLabel.snp.trailing).offset(15)
            make.bottom.trailing.equalToSuperview()
        }
    }
    
    private func makeLabel(font: UIFont, textColor: UIColor, isUnderlined: Bool) -> UILabel {
        let label = UILabel()
        
        label.font = font
        label.textColor = textColor
        label.text = "."
        label.numberOfLines = 0
        label.textAlignment = .center
        
        if isUnderlined {
            let attributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                             .underlineColor: UIColor.specialMediumGray]
            label.attributedText = NSAttributedString(string: label.text ?? "", attributes: attributes)
        }
        return label
    }
}
