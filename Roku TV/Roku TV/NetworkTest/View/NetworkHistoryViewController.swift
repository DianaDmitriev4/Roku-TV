//
//  NetworkHistoryViewController.swift
//  Roku TV
//
//  Created by User on 27.03.2024.
//

import UIKit

final class NetworkHistoryViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: NetworkTestViewModel
    
    // MARK: - GUI Variables
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 24)
        let text = "TV Remote"
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.foregroundColor, value: UIColor.specialViolet, range: NSRange(location: 0, length: 2))
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 3, length: 6))
        label.attributedText = attributedString
        
        return label
    }()
    
    private lazy var titleForVC: UILabel = {
        let label = UILabel()
        
        label.text = "History"
        label.textColor = .white
        label.font = .systemFont(ofSize: 19)
        
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "cancel"), for: .normal)
        button.addTarget(self, action: #selector(hideNetworkHistory), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var firstView = makeViewWithImage()
    private lazy var secondView = makeViewWithImage()
    private lazy var thirdView = makeViewWithImage()
    private lazy var fourthView = makeViewWithImage()
    
    private lazy var arrowImage = makeImageView(name: "downArrow")
    private lazy var secondArrow = makeImageView(name: "downArrow")
    private lazy var thirdArrow = makeImageView(name: "downArrow")
    private lazy var fourthArrow = makeImageView(name: "downArrow")
    
    private lazy var submenu: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var downloadSubmenuView = makeViewForSubmenu(imageName: "download", text: "Download", cornerRadius: 0)
    private lazy var uploadSubmenuView = makeViewForSubmenu(imageName: "upload", text: "Upload", cornerRadius: 16)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    // MARK: - Initialization
    init(viewModel: NetworkTestViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    @objc private func openSubmenu() {
        if submenu.isHidden {
            viewModel.openMenu(submenu)
            let topConstraint = viewModel.topConstraint[secondView]
            topConstraint?.update(offset: 110)
        } else {
            viewModel.hideMenu(submenu)
            let topConstraint = viewModel.topConstraint[secondView]
            topConstraint?.update(offset: 10)
        }
    }
    
    @objc private func hideNetworkHistory() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        submenu.isHidden = true
        view.backgroundColor = .backgroundGray
        
        view.addSubviews([titleLabel, cancelButton, titleForVC, firstView, secondView, thirdView, fourthView, submenu])
        
        firstView.addSubview(arrowImage)
        secondView.addSubview(secondArrow)
        thirdView.addSubview(thirdArrow)
        fourthView.addSubview(fourthArrow)
        submenu.addSubviews([downloadSubmenuView, uploadSubmenuView])
        
        makeConstraints()
        addTapGestureRecognize()
        binding()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func addTapGestureRecognize() {
        firstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openSubmenu)))
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(65)
            make.trailing.equalToSuperview().inset(20)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(274)
            make.top.equalTo(67)
        }
        
        titleForVC.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(104)
            let width = view.frame.width + 81
            make.centerX.equalTo(width / 2)
        }
        
        firstView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(137)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(254)
            make.height.equalTo(60)
        }
        
        secondView.snp.makeConstraints { make in
            viewModel.topConstraint[secondView] = make.top.equalTo(firstView.snp.bottom).offset(10).constraint
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(254)
            make.height.equalTo(60)
        }
        
        thirdView.snp.makeConstraints { make in
            make.top.equalTo(secondView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(254)
            make.height.equalTo(60)
        }
        
        fourthView.snp.makeConstraints { make in
            make.top.equalTo(thirdView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(254)
            make.height.equalTo(60)
        }
        
        let arrows = [arrowImage, secondArrow, thirdArrow, fourthArrow]
        arrows.forEach { $0.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
        } }
        
        submenu.snp.makeConstraints { make in
            make.top.equalTo(firstView.snp.bottom).inset(8)
            make.width.equalTo(firstView.snp.width)
            make.height.equalTo(108)
            make.trailing.equalToSuperview().inset(20)
        }
        
        downloadSubmenuView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(54)
        }
        
        uploadSubmenuView.snp.makeConstraints { make in
            make.top.equalTo(downloadSubmenuView.snp.bottom).offset(-10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(64)
        }
    }
    
    private func binding() {
        viewModel.arrow.binding { [weak self] arrow in
            DispatchQueue.main.async { [weak self] in
                self?.arrowImage.image = arrow
            }
        }
        
        viewModel.settingViewColor.binding { [weak self] color in
            DispatchQueue.main.async { [weak self] in
                self?.firstView.backgroundColor = color
            }
        }
    }
    
    private func makeImageView(name: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: name)
        return imageView
    }
    
    private func makeViewWithImage() -> UIView {
        let view = UIView()
        
        view.backgroundColor = .specialGray
        view.layer.cornerRadius = 16
        let imageView = makeImageView(name: "network")
        
        let label = UILabel()
        label.text = "05.05.2424"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .white
        
        view.addSubviews([imageView, label])
        
        imageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
        }
        return view
    }
    
    private func makeViewForSubmenu(imageName: String, text: String, cornerRadius: CGFloat) -> UIView {
        let view = UIView()
        
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = .specialGray
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        
        let title = UILabel()
        title.font = .boldSystemFont(ofSize: 14)
        title.textColor = .white
        title.text = text
        
        let speedLabel = UILabel()
        speedLabel.textColor = .white
        speedLabel.text = "\(String(viewModel.test.first?.download ?? 0)) mbps"
        speedLabel.attributedText = addAttributeFromString(text: speedLabel.text ?? "")
        
        view.addSubviews([imageView, title, speedLabel])
        
        imageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15)
        }
        
        title.snp.makeConstraints { make in
            make.centerY.equalTo(imageView.snp.centerY)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
        }
        
        speedLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(15)
        }
        return view
    }
    
    private func addAttributeFromString(text: String) ->  NSMutableAttributedString {
        let parts = text.components(separatedBy: " ")
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: NSRange(location: 0, length: parts[0].count))
        if parts.count > 1 {
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: parts[0].count, length: parts[1].count))
        }
        return attributedString
    }
}
