//
//  SelectDeviceViewController.swift
//  Roku TV
//
//  Created by User on 24.03.2024.
//

import UIKit

final class SelectDeviceViewController: UIViewController {
    // MARK: - GUI Variables
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoadingImage()
    }
    
    // MARK: - Private methods
    private func showLoadingImage() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "searching")
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(339)
            make.centerX.equalTo(<#T##other: any ConstraintRelatableTarget##any ConstraintRelatableTarget#>)
        }
    }
    
    private func setupUI() {
        
    }
}
