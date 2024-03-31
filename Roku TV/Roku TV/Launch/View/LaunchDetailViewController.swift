//
//  LaunchDetailViewController.swift
//  Roku TV
//
//  Created by User on 21.03.2024.
//

import UIKit

final class LaunchDetailViewController: UIViewController {
    // MARK: - GUI Variables
    private let imageView = UIImageView()
    private lazy var titleLabel = makeLabel(font: .boldSystemFont(ofSize: 38), textColor: .specialViolet, isUnderlined: false)
    private lazy var descriptionLabel = makeLabel(font: .systemFont(ofSize: 14), textColor: .specialLightGray, isUnderlined: false)
    
    private let arrowImageView: UIImageView = {
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
    
    private let labelContainerView = UIView()
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
        configurePageControl()
    }
    
    // MARK: - Initialization
    init(source: LaunchModel) {
        super.init(nibName: nil, bundle: nil)
        
        imageView.image = source.image
        imageView.contentMode = .scaleAspectFill
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
}

// MARK: - Private methods
private extension LaunchDetailViewController {
    func setupUI() {
        view.addSubviews([imageView, titleLabel, descriptionLabel, continueButton, labelContainerView])
        continueButton.addSubview(arrowImageView)
        labelContainerView.addSubviews([firstLabel, secondLabel, thirdLabel])
        makeConstraints()
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(45)
            make.bottom.equalToSuperview().inset(380)
//            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(45)
            make.bottom.equalTo(continueButton.snp.top).offset(-50)
        }
        
        continueButton.snp.makeConstraints { make in
//            make.top.equalTo(descriptionLabel.snp.bottom).offset(50)
            let height = view.frame.height
            make.top.equalToSuperview().inset(height * 0.85)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.07) // 7,389 % of screen
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(15)
            make.width.equalTo(arrowImageView.snp.height)
        }
        
        labelContainerView.snp.makeConstraints { make in
            make.top.equalTo(continueButton.snp.bottom).offset(15)
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
    
    func makeLabel(font: UIFont, textColor: UIColor, isUnderlined: Bool) -> UILabel {
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

// Page control
private extension LaunchDetailViewController {
    @objc func goNextVC() {
        guard let pageViewController = parent as? LaunchViewController else { return }
        pageViewController.goNext()
    }
    
    func configurePageControl() {
        let buttonPosition = continueButton.convert(continueButton.bounds, to: nil)
        
        guard let pageViewController = parent as? LaunchViewController else { return }
        
        if let pageControl = getPageControl(pageVC: pageViewController) {
            pageControl.pageIndicatorTintColor = .specialInactiveViolet
            pageControl.currentPageIndicatorTintColor = .specialViolet
            pageControl.center.y = buttonPosition.minY - 20
        }
    }
    
    func getPageControl(pageVC: UIPageViewController) -> UIPageControl? {
        for view in pageVC.view.subviews {
            if let pageControl = view as? UIPageControl {
                return pageControl
            }
        }
        return nil
    }
}
