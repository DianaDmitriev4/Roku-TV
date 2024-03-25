//
//  BaseVC.swift
//  Roku TV
//
//  Created by User on 25.03.2024.
//

import UIKit

class BaseVC: UIViewController {
    weak var delegate: HomeDelegate?
    
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
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBar()
    }
    
    // MARK: - Private methods
    @objc private func openLeftMenu() {
        delegate?.toggleLeftMenu()
    }
    
    @objc private func openRightMenu() {
        delegate?.toggleRightMenu()
    }
    
    private func setNavBar() {
        // Проверяем, что навигационный бар существует
        guard let navBar = navigationController?.navigationBar else { return }
        
        // Создаем кастомные кнопки
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        
        // Устанавливаем кастомные кнопки в навигационный бар
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }

}
