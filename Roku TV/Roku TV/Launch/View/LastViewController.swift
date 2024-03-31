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
    private var currentlySelectedView: UIView?
    private var isSelected = false
    private var viewModel: LaunchViewModelProtocol
    
    // MARK: - GUI Variables
    private let vectorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vector")
        return imageView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "last")
        return imageView
    }()
    
    private lazy var titleLabel = makeLabel(font: .boldSystemFont(ofSize: 27),
                                            textColor: .white,
                                            isUnderlined: false,
                                            text: "TV Remote\nwith no limitations")
    
    private lazy var descriptionLabel = makeLabel(font: .systemFont(ofSize: 14),
                                                  textColor: .specialLightGray,
                                                  isUnderlined: false,
                                                  text: "Control your TV from phone & test internet speed easily")
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Get Premium", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .specialGray
        button.isUserInteractionEnabled = false
        button.layer.borderColor = UIColor.specialViolet.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(goNextVC), for: .touchUpInside)
        
        return button
    }()
    
    private let arrowImageView: UIImageView = {
        let image = UIImageView()
        
        image.backgroundColor = .specialViolet
        image.contentMode = .center
        image.image = UIImage(named: "arrowRight")
        
        return image
    }()
    
    private lazy var firstMenuView = makeViewWithLabels(textForPeriod: "Monthly", textForWeeklyCost: "6.25$ per Week", textForPeriodCost: "25$ / month")
    private lazy var secondMenuView = makeViewWithLabels(textForPeriod: "Weekly", textForWeeklyCost: "5$ per Week", textForPeriodCost: "5$ / week")
    private lazy var thirdMenuView = makeViewWithLabels(textForPeriod: "Yearly", textForWeeklyCost: "2.4$ per Week", textForPeriodCost: "125$ / year")
    
    private let labelContainerView = UIView()
    private lazy var firstLabel = makeLabel(font: .systemFont(ofSize: 12), textColor: .specialMediumGray, isUnderlined: true, text: "Terms of Use")
    private lazy var secondLabel = makeLabel(font: .systemFont(ofSize: 12), textColor: .specialMediumGray, isUnderlined: true, text: "Privacy Policy")
    private lazy var thirdLabel = makeLabel(font: .systemFont(ofSize: 12), textColor: .specialMediumGray, isUnderlined: true, text: "Restore Purchases")
    private lazy var fourthLabel = makeLabel(font: .systemFont(ofSize: 12), textColor: .specialMediumGray, isUnderlined: true, text: "Not now")
    
    private lazy var popularView = makeViewWithLabelFromMenu(backgroundColor: .specialViolet, text: "Popular")
    private lazy var mostTakenView = makeViewWithLabelFromMenu(backgroundColor: .specialViolet, text: "Most Taken")
    private lazy var betsDealView = makeViewWithLabelFromMenu(backgroundColor: .specialViolet, text: "Bets Deal") //Is there an error in the text in figma? Maybe best?
    private lazy var saleView = makeViewWithLabelFromMenu(backgroundColor: .black, text: "Sale 75%")
    
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
    init(viewModel: LaunchViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
private extension LastViewController {
    func setupUI() {
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
        makeGradientLayer()
        makeConstraints()
        addGestureOnMenuView()
    }
    
    func makeConstraints() {
        vectorImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.32) // 32% of screen
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.32) // 32% of screen
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(70)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(80)
        }
        
        firstMenuView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(112)
            make.height.equalToSuperview().multipliedBy(0.163) // 16% of screen
            viewModel.menuViewTopConstraints[firstMenuView] = make.top.equalTo(descriptionLabel.snp.bottom).offset(35).constraint
        }
        
        secondMenuView.snp.makeConstraints { make in
            make.width.equalTo(112)
            make.height.equalToSuperview().multipliedBy(0.163)
            make.leading.equalToSuperview().inset(133)
            viewModel.menuViewTopConstraints[secondMenuView] = make.top.equalTo(descriptionLabel.snp.bottom).offset(35).constraint
        }
        
        thirdMenuView.snp.makeConstraints { make in
            make.width.equalTo(112)
            make.height.equalToSuperview().multipliedBy(0.163) //16% of screen
            make.leading.equalToSuperview().inset(250)
            viewModel.menuViewTopConstraints[thirdMenuView] = make.top.equalTo(descriptionLabel.snp.bottom).offset(35).constraint
        }
        
        continueButton.snp.makeConstraints { make in
            let heigh = view.frame.height
            make.top.equalToSuperview().inset(heigh * 0.85)
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
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.leading.bottom.top.equalToSuperview()
        }
        
        secondLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstLabel.snp.trailing).offset(15)
            make.top.bottom.equalToSuperview()
        }
        
        thirdLabel.snp.makeConstraints { make in
            make.leading.equalTo(secondLabel.snp.trailing).offset(15)
            make.top.bottom.equalToSuperview()
        }
        
        fourthLabel.snp.makeConstraints { make in
            make.leading.equalTo(thirdLabel.snp.trailing).offset(15)
            make.trailing.top.bottom.equalToSuperview()
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
}

private extension LastViewController {
    func makeGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.specialViolet.cgColor, UIColor.specialGray.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func makeViewWithLabelFromMenu(backgroundColor: UIColor, text: String) -> UIView {
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
    
    func makeViewWithLabels(textForPeriod: String, textForWeeklyCost: String, textForPeriodCost: String) -> UIView {
        let view = UIView()
        
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.specialLightGray.cgColor
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
    
    func createHorizontalGradientLine() -> UIView {
        let horizontalGradientView = UIView(frame: CGRect(x: 0, y: 0, width: 112, height: 1))
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = horizontalGradientView.bounds
        gradientLayer.colors = [UIColor.specialGray.cgColor, UIColor.specialMediumGray.cgColor, UIColor.specialGray.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        horizontalGradientView.layer.addSublayer(gradientLayer)
        
        return horizontalGradientView
        
    }
    
    func makeLabel(font: UIFont, textColor: UIColor, isUnderlined: Bool, text: String) -> UILabel {
        let label = UILabel()
        
        label.font = font
        label.textColor = textColor
        label.text = text
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

private extension LastViewController {
    @objc func selectTheView(_ sender: UITapGestureRecognizer) {
        guard let selectedView = sender.view else { return }
        viewModel.selectView(selectedView: selectedView, button: continueButton, imageView: arrowImageView)
    }
    
    @objc func goNextVC() {
        let vc = ContainerViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func addGestureOnMenuView() {
        let menus = [firstMenuView, secondMenuView, thirdMenuView]
        menus.forEach { menu in
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectTheView))
            menu.addGestureRecognizer(tapGesture)
        }
    }
}
