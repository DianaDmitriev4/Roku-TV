//
//  AppsViewController.swift
//  Roku TV
//
//  Created by User on 25.03.2024.
//

import UIKit

final class AppsViewController: UIViewController {
    // MARK: - Properties
    weak var coordinator: AppCoordinator?
    
    // MARK: - GUI Variables
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
    
    private let loadingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loading")
        return imageView
    }()
    
    private let appsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appsPicture")
        return imageView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeLoadingImage()
        setNavBar()
    }
}

// MARK: - Private func
private extension AppsViewController {
    func makeLoadingImage() {
        view.addSubview(loadingImageView)
        makeLoadingConstraints()
        view.backgroundColor = .specialGray
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.setupUI()
            self?.loadingImageView.isHidden = true
        }
    }
    
    func makeLoadingConstraints() {
        loadingImageView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.width.equalTo(270)
            make.height.equalTo(198)
        }
        
        leftButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
        
        rightButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
    }
    
    func setNavBar() {
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        
        title = "Apps"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupUI() {
        view.addSubview(appsImageView)
        makeConstraint()
    }
    
    func makeConstraint() {
        appsImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(149)
            make.height.equalTo(405)
        }
    }
}

private extension AppsViewController {
    @objc func openLeftMenu() {
        coordinator?.showMenuVC()
    }
    
    @objc func openRightMenu() {
        coordinator?.showSelectDeviceVC()
    }
}
