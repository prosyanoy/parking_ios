//
//  ProfileTitleCell.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 24.09.2022.
//

import Foundation
import UIKit

final class ProfileTitleCell: UITableViewCell {
    static var reuseIdentifier: String { "\(Self.self)" }
    
    let photoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "person.crop.circle")
        view.tintColor = .lightGray
        view.layer.borderWidth = 1.0
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = view.image!.size.width/2
        view.clipsToBounds = true
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .overpassLight17
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .overpassLight17
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = .lightGray
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        accessoryView = logoutButton
    }
    
    private func setupLayout() {
        addSubview(photoView)
        addSubview(nameLabel)
        addSubview(phoneLabel)
        addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoView.topAnchor.constraint(equalTo: topAnchor),
            photoView.bottomAnchor.constraint(equalTo: bottomAnchor),
            photoView.widthAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: logoutButton.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            
            phoneLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 16),
            phoneLabel.trailingAnchor.constraint(equalTo: logoutButton.leadingAnchor, constant: 16),
            phoneLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            logoutButton.topAnchor.constraint(equalTo: topAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}

extension ProfileTitleCell {
    func configure(with profileViewModel: ProfileViewModelProtocol, for indexPath: IndexPath) {
        let cellInfo = profileViewModel.getCellViewModel(for: indexPath)
        let phone = UserDefaultsDataManager.userPhoneNumber
        nameLabel.text = cellInfo
        phoneLabel.text = "+7 \(phone)"
    }
}
