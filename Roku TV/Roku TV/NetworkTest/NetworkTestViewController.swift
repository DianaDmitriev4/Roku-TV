//
//  NetworkTestViewController.swift
//  Roku TV
//
//  Created by User on 25.03.2024.
//

import UIKit

final class NetworkTestViewController: UIViewController {
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
    
    // MARK: - Private func
    @objc private func openLeftMenu() {
        navigationController?.pushViewController(MenuViewController(viewModel: MenuViewModel()), animated: true)
    }
    
    @objc private func openRightMenu() {
        //            navigationController?.pushViewController()
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
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20), range: NSRange(location: 0, length: parts[0].count))
            if parts.count > 1 {
                attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: parts[0].count + 1, length: parts[1].count))
            }
            label.attributedText = attributedString
        }
        return label
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
        view.addSubviews([circleView, downloadView, uploadView])
        downloadView.addSubview(downloadSpeedLabel)
        uploadView.addSubview(uploadSpeedLabel)
        
        makeConstraint()
        view.backgroundColor = .specialGray
        setNavBar()
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
    }
}








//________________________________

class ColorfulCirclesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let centerCircle = UIView(frame: CGRect(x: 100, y: 100, width: 160, height: 160))
        centerCircle.layer.cornerRadius = centerCircle.frame.width / 2
        centerCircle.backgroundColor = UIColor.red
        view.addSubview(centerCircle)
        
        let colors = [UIColor.green, UIColor.blue, UIColor.yellow, UIColor.orange, UIColor.purple]
        let radiusIncrement: CGFloat = 30
        
        for (index, color) in colors.enumerated() {
            let circle = UIView(frame: CGRect(x: 100 - CGFloat(index + 1) * radiusIncrement, y: 100 - CGFloat(index + 1) * radiusIncrement, width: 200 + CGFloat((index + 1) * 2) * radiusIncrement, height: 200 + CGFloat((index + 1) * 2) * radiusIncrement))
            circle.layer.cornerRadius = circle.frame.width / 2
            circle.layer.borderWidth = 2
            circle.layer.masksToBounds = true
            circle.backgroundColor = color
            view.addSubview(circle)
            view.sendSubviewToBack(circle)
            animateCircle(circle)
        }
    }
    
    func animateCircle(_ circle: UIView) {
        UIView.animate(withDuration: 2.0, delay: 0, options: [.autoreverse, .repeat], animations: {
            circle.alpha = 0
        }, completion: nil)
    }
}
