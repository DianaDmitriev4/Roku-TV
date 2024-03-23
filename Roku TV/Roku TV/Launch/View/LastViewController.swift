//
//  LastViewController.swift
//  Roku TV
//
//  Created by User on 22.03.2024.
//

import SnapKit
import UIKit

final class LastViewController: UIViewController {
    // MARK: - Properties
    //   private var menuViewTopConstraints: [UIView: Constraint] = [:]
    private var currentlySelectedView: UIView?
    private var isSelected = false
    private var viewModel: LaunchViewModelProtocol
    
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
    
    private lazy var titleLabel = makeLabel(font: .boldSystemFont(ofSize: 27),
                                            textColor: .white,
                                            isUnderlined: false,
                                            text: "TV Remote\nwith no limitations")
    private lazy var descriptionLabel = makeLabel(font: .systemFont(ofSize: 14),
                                                  textColor: .specialLightGrey,
                                                  isUnderlined: false,
                                                  text: "Control your TV from phone & test internet speed easily")
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Get Premium", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = isSelected ? .specialViolet : .specialGrey
        button.layer.borderColor = UIColor.specialViolet.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(goNextVC), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let image = UIImageView()
        
        image.backgroundColor = .clear
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
    
    private lazy var popularView = makeViewWithLabelFromMenu(backgroundColor: .specialViolet, text: "Popular")
    private lazy var mostTakenView = makeViewWithLabelFromMenu(backgroundColor: .specialViolet, text: "Most Taken")
    private lazy var betsDealView = makeViewWithLabelFromMenu(backgroundColor: .specialViolet, text: "Bets Deal") //Is there an error in the text in figma? Maybe best?
    private lazy var saleView = makeViewWithLabelFromMenu(backgroundColor: .black, text: "Sale 75%")
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Initialization
    init(viewModel: LaunchViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    @objc private func selectTheView(_ sender: UITapGestureRecognizer) {
        guard let selectedView = sender.view else { return }
        
        if currentlySelectedView == selectedView {
            // Return constraint
            if let topConstraint = viewModel.menuViewTopConstraints[selectedView] {
                topConstraint.update(offset: 35)
                currentlySelectedView = nil
                isSelected = false
            }
        } else {
            // Return constraint from previous
            if let currentlySelectedView,
               let topConstraint = viewModel.menuViewTopConstraints[currentlySelectedView] {
                topConstraint.update(offset: 35)
            }
            if let topConstraint = viewModel.menuViewTopConstraints[selectedView] {
                topConstraint.update(offset: 20)
                currentlySelectedView = selectedView
            }
            isSelected = true
        }
        UIView.animate(withDuration: 0.3) {
            selectedView.superview?.layoutIfNeeded()
        }
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
                          labelContainerView,
                          popularView,
                          mostTakenView,
                          betsDealView,
                          saleView])
        labelContainerView.addSubviews([firstLabel, secondLabel, thirdLabel, fourthLabel])
        continueButton.addSubview(arrowImageView)
        
        navigationItem.setHidesBackButton(true, animated: false)
        makeGradient()
        makeConstraints()
        addGestureOnMenuView()
    }
    
    private func addGestureOnMenuView() {
        let menus = [firstMenuView, secondMenuView, thirdMenuView]
        menus.forEach { menu in
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectTheView))
            menu.addGestureRecognizer(tapGesture)
        }
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
            viewModel.menuViewTopConstraints[firstMenuView] = make.top.equalTo(descriptionLabel.snp.bottom).offset(35).constraint
        }
        
        secondMenuView.snp.makeConstraints { make in
            make.width.equalTo(112)
            make.height.equalTo(132)
            make.leading.equalToSuperview().inset(133)
            viewModel.menuViewTopConstraints[secondMenuView] = make.top.equalTo(descriptionLabel.snp.bottom).offset(35).constraint
        }
        
        thirdMenuView.snp.makeConstraints { make in
            make.width.equalTo(112)
            make.height.equalTo(132)
            make.leading.equalToSuperview().inset(250)
            viewModel.menuViewTopConstraints[thirdMenuView] = make.top.equalTo(descriptionLabel.snp.bottom).offset(35).constraint
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(690)
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
        }
        
        secondLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstLabel.snp.trailing).offset(15)
        }
        
        thirdLabel.snp.makeConstraints { make in
            make.leading.equalTo(secondLabel.snp.trailing).offset(15)
        }
        
        fourthLabel.snp.makeConstraints { make in
            make.leading.equalTo(thirdLabel.snp.trailing).offset(15)
            make.trailing.equalToSuperview()
        }
        
        popularView.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(22)
            make.bottom.equalTo(firstMenuView.snp.top).inset(10)
            make.centerX.equalTo(firstMenuView.snp.centerX)
        }
        
        mostTakenView.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(22)
            make.bottom.equalTo(secondMenuView.snp.top).inset(10)
            make.centerX.equalTo(secondMenuView.snp.centerX)
        }
        
        betsDealView.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(22)
            make.bottom.equalTo(thirdMenuView.snp.top).inset(10)
            make.centerX.equalTo(thirdMenuView.snp.centerX)
        }
        
        saleView.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(22)
            make.bottom.equalTo(thirdMenuView.snp.bottom).offset(10)
            make.centerX.equalTo(thirdMenuView.snp.centerX)
        }
    }
    
    private func makeViewWithLabelFromMenu(backgroundColor: UIColor, text: String) -> UIView {
        let view = UIView()
        
        view.backgroundColor = backgroundColor
        view.layer.borderColor = UIColor.specialViolet.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 10
        
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 12)
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        
        return view
    }
    
    private func makeViewWithLabels(textForPeriod: String, textForWeeklyCost: String, textForPeriodCost: String) -> UIView {
        let view = UIView()
        
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.specialLightGrey.cgColor
        view.layer.cornerRadius = 14
        
        let periodLabel = makeLabel(font: .boldSystemFont(ofSize: 20), textColor: .white, isUnderlined: false, text: textForPeriod)
        let weeklyCostLabel = makeLabel(font: .boldSystemFont(ofSize: 12), textColor: .white, isUnderlined: false, text: textForWeeklyCost)
        let periodCostLabel = makeLabel(font: .boldSystemFont(ofSize: 14), textColor: .white, isUnderlined: false, text: textForPeriodCost)
        let firstGradientLine = createHorizontalGradientLine()
        let secondGradientLine = createHorizontalGradientLine()
        let thirdGradientLine = createHorizontalGradientLine()
        view.addSubviews([periodLabel, weeklyCostLabel, periodCostLabel, firstGradientLine, secondGradientLine, thirdGradientLine])
        
        periodLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        weeklyCostLabel.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        
        periodCostLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalToSuperview().inset(15)
        }
        
        let linesArray = [firstGradientLine, secondGradientLine, thirdGradientLine]
        linesArray.forEach { line in
            line.snp.makeConstraints { make in
                make.top.equalTo(weeklyCostLabel.snp.bottom).offset(15)
                make.trailing.leading.equalToSuperview()
            }
        }
        
        return view
    }
    
    private func createHorizontalGradientLine() -> UIView {
        let horizontalGradientView = UIView(frame: CGRect(x: 0, y: 0, width: 112, height: 1))
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = horizontalGradientView.bounds
        gradientLayer.colors = [UIColor.specialGrey.cgColor, UIColor.specialMediumGrey.cgColor, UIColor.specialGrey.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        horizontalGradientView.layer.addSublayer(gradientLayer)
        
        return horizontalGradientView
        
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
