//
//  NumCarCell.swift
//  Parking
//
//  Created by Denis Zagudaev on 24.08.2022.
//

import UIKit

class NumberCarCell: UITableViewCell, UITextFieldDelegate {
    static var reuseIdentifier: String { "\(Self.self)" }
    static var identifier = "NumberCarCell"
    let defaults = UserDefaults.standard
    private let maxNumCarCount = 9
    private let regex = try! NSRegularExpression(pattern: "[\\-\\ ]", options: .caseInsensitive)
    
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
        textField.placeholder = "A 000  AA  000"
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

extension NumberCarCell  {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullString = (textField.text ?? "") + string
        textField.text = formate(carNumber: fullString, shouldRemoveLastDigit: range.length == 1)
        return false
    }
    
    func formate(carNumber: String, shouldRemoveLastDigit: Bool) -> String {
        let range = NSString(string: carNumber).range(of: carNumber)
        var numCar = regex.stringByReplacingMatches(in: carNumber, range: range, withTemplate: "")
        
        if numCar.count > maxNumCarCount {
            let maxIndex = numCar.index(numCar.startIndex, offsetBy: maxNumCarCount)
            numCar = String(numCar[numCar.startIndex..<maxIndex])
        }
        if shouldRemoveLastDigit {
            let maxIndex = numCar.index(numCar.startIndex, offsetBy: numCar.count - 1)
            numCar = String(numCar[numCar.startIndex..<maxIndex])
        }
        let maxIndex = numCar.index(numCar.startIndex, offsetBy: numCar.count)
        let regRange = numCar.startIndex..<maxIndex
        
        switch numCar.count {
        case 1:
            let pattern = "(\\w)"
            numCar = numCar.replacingOccurrences(of: pattern, with: "$1  ", options: .regularExpression, range: regRange)
        case 2:
            let pattern = "(\\w)(\\d)"
            numCar = numCar.replacingOccurrences(of: pattern, with: "$1  $2", options: .regularExpression, range: regRange)
        case 3:
            let pattern = "(\\w)(\\d{2})"
            numCar = numCar.replacingOccurrences(of: pattern, with: "$1  $2", options: .regularExpression, range: regRange)
        case 4:
            let pattern = "(\\w)(\\d{3})"
            numCar = numCar.replacingOccurrences(of: pattern, with: "$1  $2", options: .regularExpression, range: regRange)
        case 5:
            let pattern = "(\\w)(\\d{3})(\\w)"
            numCar = numCar.replacingOccurrences(of: pattern, with: "$1  $2  $3", options: .regularExpression, range: regRange)
        case 6:
            let pattern = "(\\w)(\\d{3})(\\w{2})"
            numCar = numCar.replacingOccurrences(of: pattern, with: "$1  $2  $3", options: .regularExpression, range: regRange)
        case 7:
            let pattern = "(\\w)(\\d{3})(\\w{2})(\\d)"
            numCar = numCar.replacingOccurrences(of: pattern, with: "$1  $2  $3  $4", options: .regularExpression, range: regRange)
        case 8:
            let pattern = "(\\w)(\\d{3})(\\w{2})(\\d{2})"
            numCar = numCar.replacingOccurrences(of: pattern, with: "$1  $2  $3  $4", options: .regularExpression, range: regRange)
        case 9:
            let pattern = "(\\w)(\\d{3})(\\w{2})(\\d{3})"
            numCar = numCar.replacingOccurrences(of: pattern, with: "$1  $2  $3  $4", options: .regularExpression, range: regRange)
        default:
            break
        }
        return numCar
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let textFieldCount = textField.text?.count else { return }
        
        if textFieldCount == 15 {
            defaults.set(textField.text, forKey: "numberOfCar")
            textField.resignFirstResponder()
        }
        
        switch textFieldCount {
        case 0:
            textField.resignFirstResponder()
            textField.keyboardType = .default
            textField.becomeFirstResponder()
        case 1...3:
            textField.resignFirstResponder()
            textField.keyboardType = .numberPad
            textField.becomeFirstResponder()
        case 6:
            textField.resignFirstResponder()
            textField.keyboardType = .default
            textField.becomeFirstResponder()
        case 10:
            textField.resignFirstResponder()
            textField.keyboardType = .numberPad
            textField.becomeFirstResponder()
        case 15:
            textField.resignFirstResponder()
            textField.keyboardType = .default
            textField.becomeFirstResponder()
            textField.returnKeyType = .next
        default:
            break
        }
    }
}



