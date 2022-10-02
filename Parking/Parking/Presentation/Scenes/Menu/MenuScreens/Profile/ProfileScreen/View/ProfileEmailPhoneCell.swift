//
//  ProfileEmailPhoneCell.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 07.09.2022.
//

import Foundation
import UIKit

final class ProfileEmailPhoneCell: UITableViewCell {
    static var reuseIdentifier: String { "\(Self.self)" }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .overpassRegular17
        label.textColor = .black
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
        addSubview(titleLabel)
        addSubview(indicator)
        
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            indicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 16),
            indicator.heightAnchor.constraint(equalTo: heightAnchor, constant: -20),
            
        ])
    }
}

extension ProfileEmailPhoneCell {
    func configure(with profileViewModel: ProfileViewModelProtocol, for indexPath: IndexPath) {
        let cellInfo = profileViewModel.getCellViewModel(for: indexPath)
        titleLabel.text = cellInfo
    }
}
