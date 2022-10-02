//
//  MenuTitleCellView.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 02.10.2022.
//

import Foundation
import UIKit

final class MenuTitleCellView: UITableViewCell {
    static var reuseIdentifier: String { "\(Self.self)" }
    
    private let photoView: UIImageView = {
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
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .overpassLight17
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .overpassLight17
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()
    
    private let indicator: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        phoneLabel.text = UserDefaultsDataManager.userPhoneNumber
        setupLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        accessoryView = indicator
    }
    
    private func setupLayout() {
        addSubview(photoView)
        addSubview(nameLabel)
        addSubview(phoneLabel)
        addSubview(indicator)
        
        NSLayoutConstraint.activate([
            
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            photoView.topAnchor.constraint(equalTo: topAnchor),
            photoView.bottomAnchor.constraint(equalTo: bottomAnchor),
            photoView.widthAnchor.constraint(equalTo: heightAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: indicator.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            
            phoneLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 16),
            phoneLabel.trailingAnchor.constraint(equalTo: indicator.leadingAnchor, constant: 16),
            phoneLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            indicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 16),
            indicator.heightAnchor.constraint(equalTo: heightAnchor, constant: -20),
            
        ])
    }
}

extension MenuTitleCellView {
    func configure(with menuViewModel: MenuViewModelProtocol, for indexPath: IndexPath) {
        let cell = menuViewModel.getCellViewModel(for: indexPath)
        let phone = UserDefaultsDataManager.userPhoneNumber
        photoView.image = UIImage(systemName: cell.iconName)
        nameLabel.text = cell.title
        phoneLabel.text = "+7 \(phone)"
    }
}
