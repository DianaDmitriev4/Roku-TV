//
//  AppsViewController.swift
//  Roku TV
//
//  Created by User on 25.03.2024.
//

import UIKit

final class AppsViewController: UIViewController {
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
    
    private lazy var loadingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loading")
        return imageView
    }()
    
    private lazy var appsImageView: UIImageView = {
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
    
    // MARK: - Private func
    @objc private func openLeftMenu() {
        navigationController?.pushViewController(MenuViewController(viewModel: MenuViewModel()), animated: true)
    }
    
    @objc private func openRightMenu() {
        navigationController?.pushViewController(SelectDeviceViewController(viewModel: SelectDeviceViewModel()), animated: true)
    }
    
    private func makeLoadingImage() {
        view.addSubview(loadingImageView)
        makeLoadingConstraints()
        view.backgroundColor = .specialGray
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.setupUI()
            self?.loadingImageView.isHidden = true
        }
    }
    
    private func makeLoadingConstraints() {
        loadingImageView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        
        leftButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
        
        rightButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
    }
    
    private func setNavBar() {
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        
        title = "Apps"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(appsImageView)
        makeConstraint()
    }
    
    private func makeConstraint() {
        appsImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(149)
        }
    }
}
