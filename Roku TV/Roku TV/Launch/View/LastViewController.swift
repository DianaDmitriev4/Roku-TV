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
        button.setTitle("Get Premium", for: .normal)
        button.backgroundColor = .specialViolet
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(goNextVC), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let image = UIImageView()
        
        image.backgroundColor = .specialGrey
        image.layer.cornerRadius = 22
        image.contentMode = .center
        image.image = UIImage(named: "arrowRight")
        
        return image
    }()
    
    private lazy var firstMenuView = makeViewWithLabels(textForPeriod: "Monthly", textForWeeklyCost: "6.25$ per Week", textForPeriodCost: "25$ / month")
    private lazy var secondMenuView = makeViewWithLabels(textForPeriod: "Weekly", textForWeeklyCost: "5$ per Week", textForPeriodCost: "5$ / week")
    private lazy var thirdMenuView = makeViewWithLabels(textForPeriod: "Yearly", textForWeeklyCost: "2.4$ per Week", textForPeriodCost: "125$ / year")
    
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
        view.addSubviews([vectorImageView,
                          imageView,
                          titleLabel,
                          descriptionLabel,
                          continueButton,
                          firstMenuView,
                          secondMenuView,
                          thirdMenuView,
                          labelContainerView])
        labelContainerView.addSubviews([firstLabel, secondLabel, thirdLabel, fourthLabel])
        continueButton.addSubview(arrowImageView)
        
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
        
        firstMenuView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(112)
            make.height.equalTo(132)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(35)
        }
        
        secondMenuView.snp.makeConstraints { make in
            make.width.equalTo(112)
            make.height.equalTo(132)
            make.leading.equalTo(firstMenuView.snp.trailing).offset(5)
            make.centerY.equalTo(firstMenuView.snp.centerY)
        }
        
        thirdMenuView.snp.makeConstraints { make in
            make.width.equalTo(112)
            make.height.equalTo(132)
            make.leading.equalTo(secondMenuView.snp.trailing).offset(5)
            make.centerY.equalTo(secondMenuView.snp.centerY)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(thirdMenuView.snp.bottom).offset(35)
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
            make.centerX.equalTo(view.snp.centerX)
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
            make.leading.equalTo(secondLabel.snp.trailing).offset(15)
            make.top.equalToSuperview()
        }
        
        fourthLabel.snp.makeConstraints { make in
            make.leading.equalTo(thirdLabel.snp.trailing).offset(15)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func makeViewWithLabels(textForPeriod: String, textForWeeklyCost: String, textForPeriodCost: String) -> UIView {
        let view = UIView()
        
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.specialLightGrey.cgColor
        view.layer.cornerRadius = 14
        
        let periodLabel = makeLabel(font: .boldSystemFont(ofSize: 20), textColor: .white, isUnderlined: false, text: textForPeriod)
        let weeklyCostLabel = makeLabel(font: .boldSystemFont(ofSize: 12), textColor: .white, isUnderlined: false, text: textForWeeklyCost)
        let periodCostLabel = makeLabel(font: .boldSystemFont(ofSize: 14), textColor: .white, isUnderlined: false, text: textForPeriodCost)
        view.addSubviews([periodLabel, weeklyCostLabel, periodCostLabel])
        
        periodLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        weeklyCostLabel.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        
        periodCostLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalToSuperview().inset(12)
        }
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
