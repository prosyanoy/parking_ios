//
//  ForeignNumber.swift
//  Parking
//
//  Created by mac on 07.09.2022.
//

import UIKit

class ForeignNumberCell: UITableViewCell {
    static var reuseIdentifier: String { "\(Self.self)" }
    static var identifier = "ForeignNumberCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        contentView.backgroundColor = .white
        numberTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "Placeholder Text", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.autocapitalizationType = .allCharacters
        textField.placeholder = "Foreign Number"
        textField.addTarget(self, action: #selector(textFieldDidChangeSelection(_:)), for: .editingChanged)
        return textField
    }()
    
    func setupLayout(){
        contentView.addSubview(self.numberTextField)
        NSLayoutConstraint.activate([
            numberTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            numberTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            numberTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            numberTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

extension ForeignNumberCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("\(textField)")
    }
}

