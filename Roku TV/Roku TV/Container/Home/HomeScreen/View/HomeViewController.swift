//
//  HomeViewController.swift
//  Roku TV
//
//  Created by User on 23.03.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Properties
    private var viewModel: HomeViewModelProtocol
    weak var delegate: HomeDelegate?
    
    // MARK: - GUI variables
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "left"), for: .normal)
        button.addTarget(self, action: #selector(openLeftMenu), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "right"), for: .normal)
        button.addTarget(self, action: #selector(openRightMenu), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var panelImageView = makeImageView(name: "home")
    
    private lazy var volumeView = makeControlViewWithImage(backgroundColor: .specialGrayForButtons, cornerRadius: 20, imageName: "vol")
    private lazy var channelView = makeControlViewWithImage(backgroundColor: .specialGrayForButtons, cornerRadius: 20, imageName: "ch")
    
    private let containerView = UIView()
    private lazy var homeView = makeMiddleViewsWithImage(backgroundColor: .specialGrayForButtons, imageName: "homeIcon")
    private lazy var soundView = makeMiddleViewsWithImage(backgroundColor: .specialGrayForButtons, imageName: "sound")
    private lazy var backView = makeMiddleViewsWithImage(backgroundColor: .specialGrayForButtons, imageName: "back")
    private lazy var powerView = makeMiddleViewsWithImage(backgroundColor: .specialViolet, imageName: "power")
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Initialization
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
private extension HomeViewController {
    func setupUI() {
        view.backgroundColor = .specialGray
        title = "Remote"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        view.addSubviews([panelImageView, volumeView, containerView, channelView])
        containerView.addSubviews([homeView, soundView, backView, powerView])
        makeConstraint()
        setNavBar()
        binding()
    }
    
    func setNavBar() {
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func makeConstraint() {
        leftButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
        
        rightButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
        
        panelImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(110)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalTo(panelImageView.snp.height)
            make.leading.trailing.equalToSuperview().inset(55)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(panelImageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        volumeView.snp.makeConstraints { make in
            make.top.equalTo(panelImageView.snp.bottom).offset(77)
            make.height.equalToSuperview().multipliedBy(0.25)
            make.width.equalTo(75)
            make.leading.equalToSuperview().inset(40)
        }
        
        homeView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.16)
            make.width.equalTo(75)
        }
        
        soundView.snp.makeConstraints { make in
            make.top.equalTo(homeView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.16)
            make.width.equalTo(75)
        }
        
        backView.snp.makeConstraints { make in
            make.top.equalTo(soundView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.16)
            make.width.equalTo(75)
        }
        
        powerView.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.16)
            make.width.equalTo(75)
        }
        
        channelView.snp.makeConstraints { make in
            make.top.equalTo(panelImageView.snp.bottom).offset(77)
            make.height.equalTo(volumeView.snp.height)
            make.width.equalTo(75)
            make.trailing.equalToSuperview().inset(40)
        }
    }
}

private extension HomeViewController {
    @objc func openLeftMenu() {
        delegate?.toggleLeftMenu()
    }
    
    @objc func openRightMenu() {
        delegate?.toggleRightMenu()
    }
    
    func binding() {
        viewModel.homeImage.binding { [weak self] image in
            self?.panelImageView.image = image
        }
    }
}

private extension HomeViewController {
    func makeControlViewWithImage(backgroundColor: UIColor, cornerRadius: CGFloat, imageName: String) -> UIView{
        let view = UIView()
        
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
        view.layer.shadowColor = UIColor.specialShadowViolet.cgColor
        view.layer.shadowOffset = CGSize(width: view.bounds.width , height: 5)
        view.layer.shadowRadius = 0
        view.layer.shadowOpacity = 1
        
        let plusImage = makeImageView(name: "plus")
        plusImage.contentMode = .scaleAspectFit
        let middleImage = makeImageView(name: imageName)
        middleImage.contentMode = .scaleAspectFit
        let minusImage = makeImageView(name: "minus")
        minusImage.contentMode = .scaleAspectFit
        view.addSubviews([plusImage, middleImage, minusImage])
        
        plusImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
        }
        
        middleImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(88)
            make.center.equalTo(view.snp.center)
            make.height.equalTo(20)
        }
        
        minusImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
        }
        return view
    }
    
    func makeMiddleViewsWithImage(backgroundColor: UIColor, imageName: String) -> UIView {
        let view = UIView()
        
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.specialShadowViolet.cgColor
        view.layer.shadowOffset = CGSize(width: view.bounds.width , height: 5)
        view.layer.shadowRadius = 0
        view.layer.shadowOpacity = 1
        
        let image = makeImageView(name: imageName)
        view.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.width.height.equalTo(24)
        }
        
        return view
    }
    
    func makeImageView(name: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: name)
        return imageView
    }
}

// MARK: - MenuDelegate
extension HomeViewController: MenuDelegate {
    func changeToTouchpad() {
        viewModel.changeImageToTouchpad()
    }
    
    func changeToRemote() {
        viewModel.changeImageToRemote()
    }
}
