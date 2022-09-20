//
//  StsCell.swift
//  Parking
//
//  Created by mac on 25.08.2022.
//

import UIKit

class StsCell: UITableViewCell, UITextFieldDelegate {
    static var reuseIdentifier: String { "\(Self.self)" }
    static var identifier = "StsCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        stsAndNameCarTextField.delegate = self
        contentView.backgroundColor = .white
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let stsAndNameCarLabel: UILabel = {
       let lable = UILabel()
        lable.textColor = .black
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    let stsAndNameCarTextField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "Placeholder Text", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.placeholder = "Необязательно"
        textField.returnKeyType = .next
        return textField
    }()
    
    func setupLayout(){
        contentView.addSubview(stsAndNameCarLabel)
        contentView.addSubview(stsAndNameCarTextField)
        NSLayoutConstraint.activate([
            stsAndNameCarLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stsAndNameCarLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stsAndNameCarLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stsAndNameCarLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stsAndNameCarTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            stsAndNameCarTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stsAndNameCarTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stsAndNameCarTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

