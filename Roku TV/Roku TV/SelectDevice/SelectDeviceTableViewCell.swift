//
//  SelectDeviceTableViewCell.swift
//  Roku TV
//
//  Created by User on 24.03.2024.
//

import UIKit

final class SelectDeviceTableViewCell: UITableViewCell {
    // MARK: - GUI Variables
    private lazy var container: UIView = {
       let view = UIView()
        
        view.backgroundColor = .specialGray
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .white
        
        return label
    }()
    
     lazy var selectImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "unselect")
        return imageView
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func set(_ dataSource: SelectDeviceModel) {
        titleLabel.text = dataSource.deviceName
    }
    
    // MARK: - Private methods
    private func setupUI() {
        backgroundColor = .backgroundGray
        addSubview(container)
        container.addSubviews([titleLabel, selectImageView])
        makeConstraints()
    }
    
    private func makeConstraints() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.width.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(21)
        }
        
        selectImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(18)
        }
    }
}
