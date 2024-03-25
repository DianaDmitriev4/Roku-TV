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
       let view = UIImageView()
        view.image = UIImage(named: "loading")
        return view
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        makeLoadingImage()
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
        makeConstraint()
    }
    
    private func makeConstraint() {
        
    }
}
