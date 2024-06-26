//
//  SelectDeviceViewController.swift
//  Roku TV
//
//  Created by User on 24.03.2024.
//

import UIKit

final class SelectDeviceViewController: UIViewController {
    // MARK: - Properties
    var viewModel: SelectDeviceViewModelProtocol?
    weak var delegate: HomeDelegate?
    
    // MARK: - GUI Variables
    private let titleLabel: UILabel = {
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
        button.addTarget(self, action: #selector(hideVC), for: .touchUpInside)
        
        return button
    }()
    
    private let selectLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Select a device"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 19)
        
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 70
        table.backgroundColor = .backgroundGray
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoadingImage()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK: - Private methods
private extension SelectDeviceViewController {
    func setupInitialUI() {
        view.backgroundColor = .backgroundGray
        view.addSubviews([titleLabel, cancelButton])
        makeInitialConstraints()
    }
    
    func makeInitialConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(65)
            make.trailing.equalToSuperview().inset(20)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.trailing.equalTo(titleLabel.snp.leading).offset(-125)
            make.height.width.equalTo(24)
            make.top.equalTo(67)
        }
    }
    
    func setupUI() {
        view.addSubviews([selectLabel, tableView])
        makeConstraints()
        tableView.register(SelectDeviceTableViewCell.self, forCellReuseIdentifier: "SelectDeviceTableViewCell")
    }
    
    func makeConstraints() {
        selectLabel.snp.makeConstraints { make in
            let width = view.frame.width + 81
            make.top.equalToSuperview().inset(104)
            make.centerX.equalTo(width / 2)
        }
        
        tableView.snp.makeConstraints { make in
            let width = view.frame.width + 81
            make.centerX.equalTo(width / 2)
            make.top.equalTo(selectLabel.snp.bottom).offset(20)
            make.width.equalTo(254)
            make.height.equalTo(view.frame.height)
        }
    }
}

private extension SelectDeviceViewController {
    @objc func hideVC() {
        if self.parent is ContainerViewController {
            delegate?.hideRightMenu()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func showLoadingImage() {
        setupInitialUI()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "searching")
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(339)
            let width = view.frame.width + 81
            make.centerX.equalTo(width / 2)
            make.height.equalTo(134)
            make.width.equalTo(154)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            imageView.isHidden = true
            self?.setupUI()
        }
    }
}

// MARK: - UITableViewDataSource
extension SelectDeviceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.devices.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectDeviceTableViewCell", for: indexPath) as? SelectDeviceTableViewCell,
              let viewModel else { return UITableViewCell() }
        
        cell.set(viewModel.devices[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SelectDeviceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previouslySelectedIndexPath = viewModel?.selectCell,
           let previouslySelectedCell = tableView.cellForRow(at: previouslySelectedIndexPath) as? SelectDeviceTableViewCell {
            previouslySelectedCell.selectImageView.image = UIImage(named: "unselect")
            previouslySelectedCell.container.backgroundColor = .specialGray
        }
        viewModel?.selectCell = indexPath
        if let selectedCell = tableView.cellForRow(at: indexPath) as? SelectDeviceTableViewCell {
            selectedCell.selectImageView.image = UIImage(named: "select")
            selectedCell.container.backgroundColor = .specialViolet
        }
    }
}
