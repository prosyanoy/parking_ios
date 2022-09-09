//
//  CodeEnterViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 25.08.2022.
//

import UIKit

final class CodeEnterViewController: UIViewController, UITextFieldDelegate {
    
    let viewModel: CodeEnterViewModelProtocol
    
    init(viewModel: CodeEnterViewModelProtocol, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        titleLabel.text = "Подтверждение номера +7 \(viewModel.inputNumber)"
        setupLayout()
        setDelegates()
        codeConfirmButton.addTarget(self, action: #selector(checkConfirmationCode(_:)), for: .touchUpInside)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .black
        label.font = .overpassBold17
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let codeTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textContentType = .oneTimeCode
        textfield.textAlignment = .center
        textfield.placeholder = "Введите код"
        textfield.keyboardType = .decimalPad
        textfield.layer.cornerRadius = 10
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        return textfield
    }()
    
    private let codeConfirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    private func setDelegates() {
        codeTextField.delegate = self
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(codeTextField)
        view.addSubview(codeConfirmButton)
        
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            codeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            codeTextField.widthAnchor.constraint(equalToConstant: 200),
            codeTextField.heightAnchor.constraint(equalToConstant: 50),
            
            codeConfirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeConfirmButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 100),
            codeConfirmButton.widthAnchor.constraint(equalToConstant: 300),
            codeConfirmButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    @objc func checkConfirmationCode(_ sender: UIButton) {
        if let inputCode = codeTextField.text {
        let value = viewModel.checkConfirmationCode(inputCode: inputCode)
            if value {
                let defaults = UserDefaults.standard
                defaults.set(viewModel.inputNumber, forKey: "Phone")
                let phone = defaults.string(forKey: "Phone") ?? ""
                print(phone)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }
}
