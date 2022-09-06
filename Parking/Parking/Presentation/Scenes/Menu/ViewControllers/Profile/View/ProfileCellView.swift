//
//  ProfileCellView.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 06.09.2022.
//

import Foundation
import UIKit

final class ProfileCellView: UITableViewCell {
    static var reuseIdentifier: String { "\(Self.self)" }
    
    private let profileTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
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

            profileTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileTextField.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        ])
    }
}
