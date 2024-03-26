//
//  NetworkTestViewController.swift
//  Roku TV
//
//  Created by User on 25.03.2024.
//

import UIKit

final class NetworkTestViewController: UIViewController {
    // MARK: - Properties
    private var isAnimate = false
    private let viewModel: NetworkTestViewModelProtocol
    
    // MARK: - GUI Variables
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "left"), for: .normal)
        button.addTarget(self, action: #selector(openLeftMenu), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "networkTest"), for: .normal)
        button.addTarget(self, action: #selector(openRightMenu), for: .touchUpInside)
        
        return button
    }()
    
    
    private lazy var circleView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 80
        view.backgroundColor = .specialViolet
        
        return view
    }()
    
    private lazy var labelForCircle: UILabel = {
        let label = UILabel()
        
        label.text = "START"
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var imageFromContainer: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "download")
        return imageView
    }()
    
    private lazy var labelFromContainer: UILabel = {
        let label = UILabel()
        
        label.text = "DOWNLOAD"
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var speedLabelInCircle: UILabel = {
        let label = UILabel()
        
        label.text = "\(String(viewModel.test.first?.download ?? 0))\n MBPS"
        label.textColor = .white
        
        let parts = label.text?.components(separatedBy: "\n")
        
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        if let parts {
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 32), range: NSRange(location: 0, length: parts[0].count))
            if parts.count > 1 {
                attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: parts[0].count + 1, length: parts[1].count))
                attributedString.addAttribute(.foregroundColor, value: UIColor.specialVioletForText, range: NSRange(location: parts[0].count + 1, length: parts[1].count))
            }
            label.attributedText = attributedString
        }
        
        return label
    }()
    
    private lazy var downloadView = makeBottomViews(text: "Download", imageName: "download")
    private lazy var uploadView = makeBottomViews(text: "Upload", imageName: "upload")
    
    private lazy var downloadSpeedLabel = makeSpeedLabel()
    private lazy var uploadSpeedLabel = makeSpeedLabel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setNavBar()
    }
    
    init(viewModel: NetworkTestViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private func
    @objc private func openLeftMenu() {
        navigationController?.pushViewController(MenuViewController(viewModel: MenuViewModel()), animated: true)
    }
    
    @objc private func openRightMenu() {
        //            navigationController?.pushViewController()
    }
    
    @objc private func animateView() {
        if !isAnimate {
            let colors: [UIColor] = [.circle1, .circle2, .circle3]
            
            for (index, color) in colors.enumerated() {
                let radius: CGFloat = 80 + CGFloat(index + 1) * 30
                let subCircle = UIView(frame: CGRect(x: 80 - radius, y: 80 - radius, width: radius * 2, height: radius * 2))
                subCircle.layer.cornerRadius = radius
                subCircle.layer.masksToBounds = true
                subCircle.backgroundColor = color
                
                circleView.addSubview(subCircle)
                circleView.sendSubviewToBack(subCircle)
                animateCircle(subCircle)
            }
            labelForCircle.isHidden = true
            containerView.isHidden = false
            downloadSpeedLabel.text = "\(String(viewModel.test.first?.download ?? 0)) mbps"
            isAnimate.toggle()
        } else {
            circleView.subviews.forEach { subview in
                subview.layer.removeAnimation(forKey: "pulse")
                if subview != labelForCircle,
                   subview != containerView {
                    subview.removeFromSuperview()
                }
            }
            labelForCircle.isHidden = false
            containerView.isHidden = true
            uploadSpeedLabel.text = "\(String(viewModel.test.first?.upload ?? 0)) mbps"
            isAnimate.toggle()
        }
    }
    
    private func animateCircle(_ circle: UIView) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 1.0
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.fromValue = 0.5
        animation.toValue = 1
        circle.layer.add(animation, forKey: "pulse")
    }
    
    private func setNavBar() {
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        
        title = "Network Test"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func makeSpeedLabel() -> UILabel {
        let label = UILabel()
        
        label.textColor = .white
        label.text = "--:--"
        
        let parts = label.text?.components(separatedBy: " ")
        
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        if let parts {
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: NSRange(location: 0, length: parts[0].count))
            if parts.count > 1 {
                attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: parts[0].count + 1, length: parts[1].count))
            }
            label.attributedText = attributedString
        }
        return label
    }
    
    private func addAttributeFromString(text: String) {
        
    }
    
    private func makeBottomViews(text: String, imageName: String) -> UIView {
        let view = UIView()
        
        view.backgroundColor = .specialGrayForButtons
        view.layer.shadowColor = UIColor.specialShadowViolet.cgColor
        view.layer.shadowOffset = CGSize(width: view.bounds.width , height: 5)
        view.layer.shadowRadius = 0
        view.layer.shadowOpacity = 0.8
        view.layer.cornerRadius = 16
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = text
        label.textColor = .white
        
        view.addSubviews([imageView, label])
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalToSuperview().inset(15)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        return view
    }
    
    private func setupUI() {
        view.backgroundColor = .specialGray
        view.addSubviews([circleView, downloadView, uploadView])
        downloadView.addSubview(downloadSpeedLabel)
        uploadView.addSubview(uploadSpeedLabel)
        circleView.addSubviews([labelForCircle, containerView])
        containerView.addSubviews([imageFromContainer, labelFromContainer, speedLabelInCircle])
        containerView.isHidden = true
        
        makeConstraint()
        addGesture()
        setNavBar()
    }
    
    private func addGesture() {
        circleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateView)))
    }
    
    private func makeConstraint() {
        leftButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
        
        rightButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
        
        circleView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(288)
            make.centerX.equalTo(view.snp.centerX)
            make.width.height.equalTo(160)
        }
        
        labelForCircle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        downloadView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalToSuperview().inset(607)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        uploadView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(downloadView.snp.bottom).offset(15)
            make.height.equalTo(60)
        }
        
        downloadSpeedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(downloadView.snp.centerY)
            make.trailing.equalToSuperview().inset(15)
        }
        
        uploadSpeedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(uploadView.snp.centerY)
            make.trailing.equalToSuperview().inset(15)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        speedLabelInCircle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(55)
        }

        imageFromContainer.snp.makeConstraints { make in
            make.bottom.equalTo(speedLabelInCircle.snp.top).offset(-10)
            make.leading.equalToSuperview().inset(29)
        }

        
        labelFromContainer.snp.makeConstraints { make in
            make.centerY.equalTo(imageFromContainer.snp.centerY)
            make.leading.equalTo(imageFromContainer.snp.trailing).offset(5)
        }
    }
}
