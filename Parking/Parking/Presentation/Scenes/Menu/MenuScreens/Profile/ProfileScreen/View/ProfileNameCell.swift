//
//  ProfileCellView.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 06.09.2022.
//

import Foundation
import UIKit

final class ProfileNameCell: UITableViewCell {
    static var reuseIdentifier: String { "\(Self.self)" }
    
    let profileTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.font = .overpassMedium17
        textField.isUserInteractionEnabled = true
        textField.returnKeyType = .done
        return textField
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
    }
    
    private func setupLayout() {
        addSubview(profileTextField)
        
        NSLayoutConstraint.activate([
            
            profileTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileTextField.topAnchor.constraint(equalTo: topAnchor),
            profileTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}

extension ProfileNameCell {
    func configure(with profileViewModel: ProfileViewModelProtocol, for indexPath: IndexPath) {
        let cellInfo = profileViewModel.getCellViewModel(for: indexPath)
        profileTextField.text = cellInfo
        profileTextField.placeholder = "Необязательно"
    }
}
