//
//  SelectDeviceViewController.swift
//  Roku TV
//
//  Created by User on 24.03.2024.
//

import UIKit

final class SelectDeviceViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var titleLabel: UILabel = {
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
        return button
    }()
    
    private lazy var selectLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Select a device"
        label.textColor = .white
        label.font = .systemFont(ofSize: 19)
        
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        
        return table
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoadingImage()
    }
    
    // MARK: - Private methods
    private func showLoadingImage() {
        setupInitialUI()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "searching")
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(339)
            let width = view.frame.width + 81
            make.centerX.equalTo(width / 2)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            imageView.isHidden = true
            self?.setupUI()
        }
    }
    
    private func setupInitialUI() {
        view.backgroundColor = .backgroundGray
        view.addSubviews([titleLabel, cancelButton])
        makeInitialConstraints()
    }
    
    private func makeInitialConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(65)
            make.trailing.equalToSuperview().inset(20)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(274)
            make.top.equalTo(67)
        }
    }
    
    private func setupUI() {
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
    }
}
