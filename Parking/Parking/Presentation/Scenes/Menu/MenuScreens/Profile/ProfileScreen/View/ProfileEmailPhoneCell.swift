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
        label.font = .overpassBold17
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()
    
    private let rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .overpassMedium17
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        accessoryType = .disclosureIndicator
    }
    
    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(rightLabel)
        
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -56),
            rightLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
}

extension ProfileEmailPhoneCell {
    func configure(with profileViewModel: ProfileViewModelProtocol, for indexPath: IndexPath) {
        let cellInfo = profileViewModel.getCellViewModel(for: indexPath)
        switch indexPath.section {
        case 3:
            titleLabel.text = "Телефон"
            rightLabel.text = cellInfo
        case 4:
            titleLabel.text = "E-mail"
            rightLabel.text = cellInfo 
        default:
            break
        }
    }
}
