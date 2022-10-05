//
//  ProfileDeleteLogoutCell.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 07.09.2022.
//

import Foundation
import UIKit

final class ProfileDeleteCell: UITableViewCell {
    static var reuseIdentifier: String { "\(Self.self)" }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .overpassRegular17
        label.textColor = .lightGray
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
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
    }
    
    private func setupLayout() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
}

extension ProfileDeleteCell {
    func configure(with profileViewModel: ProfileViewModelProtocol, for indexPath: IndexPath) {
        let cell = profileViewModel.getCellViewModel(for: indexPath)
        titleLabel.text = cell
    }
}
