//
//  MenuViewController.swift
//  Roku TV
//
//  Created by User on 23.03.2024.
//

import UIKit

final class MenuViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 24)
        
                let attributedString = NSMutableAttributedString(string: "Roku TV")
                attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 4)) // Часть текста будет красного цвета
                attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 4, length: 7)) // Часть текста будет синего цвета

                label.attributedText = attributedString
        
        return label
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.addSubviews([titleLabel])
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(65)
            make.leading.equalToSuperview().inset(20)
        }
    }
    
    private func makeImageView(name: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: name)
        return imageView
    }
//    private func setNavBar() {
//                let text = "Roku TV"
//                let attributedString = NSMutableAttributedString(string: text)
//                attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 4)) // Первая часть текста белая
//                attributedString.addAttribute(.foregroundColor, value: UIColor.specialViolet, range: NSRange(location: 4, length: 3)) // Вторая часть текста синяя
//
//                let button = UIButton(type: .custom)
//                button.setAttributedTitle(attributedString, for: .normal)
//                button.sizeToFit()
//                
//                let customButton = UIBarButtonItem(customView: button)
//                navigationItem.leftBarButtonItem = customButton
//            }
        }
