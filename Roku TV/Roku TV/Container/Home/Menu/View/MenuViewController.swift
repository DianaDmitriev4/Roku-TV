//
//  MenuViewController.swift
//  Roku TV
//
//  Created by User on 23.03.2024.
//

import UIKit

final class MenuViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: MenuViewModelProtocol
    weak var delegate: HomeDelegate?
    weak var menuDelegate: MenuDelegate?
    
    // MARK: - GUI Variables
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 24)
        
        let text = "Roku TV"
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 4))
        attributedString.addAttribute(.foregroundColor, value: UIColor.specialViolet, range: NSRange(location: 4, length: 3))
        label.attributedText = attributedString
        
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "cancel"), for: .normal)
        button.addTarget(self, action: #selector(hideMenu), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var firstView = makeViewWithImage(imageName: "remote", labelText: "Remote", isArrowImage: false)
    private lazy var secondView = makeViewWithImage(imageName: "apps", labelText: "Apps", isArrowImage: false)
    private lazy var thirdView = makeViewWithImage(imageName: "network", labelText: "Network Test", isArrowImage: false)
    private lazy var fourthView = makeViewWithImage(imageName: "setting", labelText: "Settings", isArrowImage: false)
    private lazy var arrowImage = makeImageView(name: "downArrow")
    private lazy var fifthView = makeViewWithImage(imageName: "touchpad", labelText: "Touch Pad", isArrowImage: false)
    
    private lazy var submenu: UIView = {
        let view = UIView()
        
        view.backgroundColor = .specialGrayForSubview
        
        let contactView = makeViewWithImage(imageName: "contact", labelText: "Contact Us", isArrowImage: true)
        let privacyPolicy = makeViewWithImage(imageName: "privacy", labelText: "Privacy Policy", isArrowImage: true)
        let termsOfUse = makeViewWithImage(imageName: "terms", labelText: "Terms of Use", isArrowImage: true)
        let shareView = makeViewWithImage(imageName: "share", labelText: "Share the App", isArrowImage: true)
        
        let views = [contactView, privacyPolicy, termsOfUse, shareView]
        view.addSubviews(views)
   
        contactView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(15)
            make.height.equalToSuperview().multipliedBy(0.18)
        }
        
        privacyPolicy.snp.makeConstraints { make in
            make.top.equalTo(contactView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalToSuperview().multipliedBy(0.18)
        }
        
        termsOfUse.snp.makeConstraints { make in
            make.top.equalTo(privacyPolicy.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalToSuperview().multipliedBy(0.18)
        }
        
        shareView.snp.makeConstraints { make in
            make.top.equalTo(termsOfUse.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalToSuperview().multipliedBy(0.18)
            make.bottom.equalToSuperview().inset(20)
        }
        return view
    }()
    
    private lazy var switchButton: UISwitch = {
        let switchButton = UISwitch()
        
        switchButton.thumbTintColor = .black
        switchButton.onTintColor = .specialViolet
        switchButton.addTarget(self, action: #selector(toggleSwitchAction), for: .valueChanged)
        
        return switchButton
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Initialization
    init(viewModel: MenuViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
private extension MenuViewController {
    func setupUI() {
        submenu.isHidden = true
        view.backgroundColor = .backgroundGray
        
        view.addSubviews([titleLabel, cancelButton, firstView, secondView, thirdView, fourthView, submenu, fifthView])
        fourthView.addSubview(arrowImage)
        fifthView.addSubview(switchButton)
        
        makeConstraints()
        addTapGestureRecognize()
        binding()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(65)
            make.leading.equalToSuperview().inset(20)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(125)
            make.height.width.equalTo(24)
            make.top.equalTo(67)
        }
        
        firstView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(114)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(254)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        secondView.snp.makeConstraints { make in
            make.top.equalTo(firstView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(254)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        thirdView.snp.makeConstraints { make in
            make.top.equalTo(secondView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(254)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        fourthView.snp.makeConstraints { make in
            make.top.equalTo(thirdView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(254)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview().inset(20)
        }
        
        submenu.snp.makeConstraints { make in
            make.top.equalTo(fourthView.snp.bottom).inset(8)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(101)
            make.bottom.equalTo(fifthView.snp.top).offset(-34)
        }
        
        fifthView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(254)
            make.height.equalToSuperview().multipliedBy(0.07)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        switchButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview().inset(15)
        }
    }
    
    func binding() {
        viewModel.arrow.binding { [weak self] arrow in
            DispatchQueue.main.async { [weak self] in
                self?.arrowImage.image = arrow
            }
        }
        
        viewModel.settingViewColor.binding { [weak self] color in
            DispatchQueue.main.async { [weak self] in
                self?.fourthView.backgroundColor = color
            }
        }
    }
}

private extension MenuViewController {
    func makeImageView(name: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: name)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    func makeViewWithImage(imageName: String, labelText: String, isArrowImage: Bool) -> UIView {
        let view = UIView()
        
        view.backgroundColor = .specialGray
        view.layer.cornerRadius = 16
        let imageView = makeImageView(name: imageName)
        
        let label = UILabel()
        label.text = labelText
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .white
        
        view.addSubviews([imageView, label])
        
        imageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(20)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
        }
        
        if isArrowImage {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "arrow")
            imageView.contentMode = .scaleAspectFill
            view.addSubview(imageView)
            
            imageView.snp.makeConstraints { make in
                make.top.trailing.bottom.equalToSuperview().inset(20)
            }
        }
        return view
    }
}

private extension MenuViewController {
    @objc func hideMenu() {
        if self.parent is ContainerViewController {
            delegate?.hideLeftMenu()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func openRemote() {
        if !(self.parent is ContainerViewController) {
            let vc = ContainerViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    @objc func openSubmenu() {
        if submenu.isHidden {
            viewModel.openMenu(submenu)
        } else {
            viewModel.hideMenu(submenu)
        }
    }
    
    @objc func toggleSwitchAction() {
        if switchButton.isOn {
            menuDelegate?.changeToTouchpad()
        } else {
            menuDelegate?.changeToRemote()
        }
    }
    
    @objc func openApps() {
        let navController = UINavigationController(rootViewController: AppsViewController())
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    @objc func openNetworkTest() {
        let navController = UINavigationController(rootViewController: NetworkTestViewController(viewModel: NetworkTestViewModel()))
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    func addTapGestureRecognize() {
        firstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openRemote)))
        secondView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openApps)))
        thirdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openNetworkTest)))
        fourthView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openSubmenu)))
    }
}
