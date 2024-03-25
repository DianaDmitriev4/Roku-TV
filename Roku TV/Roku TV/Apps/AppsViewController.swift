//
//  AppsViewController.swift
//  Roku TV
//
//  Created by User on 25.03.2024.
//

import UIKit

final class AppsViewController: BaseVC {
    // MARK: - GUI Variables
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
        title = "Apps"
    }
    
    // MARK: - Private func
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
