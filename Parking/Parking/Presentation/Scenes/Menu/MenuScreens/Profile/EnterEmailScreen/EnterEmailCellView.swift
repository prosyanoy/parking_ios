//
//  EnterEmailCellView.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 10.09.2022.
//

import Foundation
import UIKit

final class EnterEmailCellView: UITableViewCell {
    static var reuseIdentifier: String { "\(Self.self)" }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "E-mail"
        label.font = .overpassMedium17
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
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
        addSubview(titleLabel)
        addSubview(emailTextField)

        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            emailTextField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            emailTextField.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
}
