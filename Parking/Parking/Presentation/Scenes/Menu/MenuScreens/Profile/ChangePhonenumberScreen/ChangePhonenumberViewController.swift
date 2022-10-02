//
//  ChangePhonenumberViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 29.09.2022.
//

import Foundation
import UIKit

final class ChangePhonenumberViewController: UIViewController, UITextFieldDelegate {
    
    let viewModel: ChangePhonenumberViewModelProtocol
    var bottomButtonConstraint = NSLayoutConstraint()
    
    init(viewModel: ChangePhonenumberViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Телефон"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let phonenumberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        let leftLabel = UILabel()
        leftLabel.text = "  +7 "
        leftLabel.textColor = .black
        leftLabel.font = .overpassMedium17
        textField.leftView = leftLabel
        textField.leftViewMode = .always
        textField.keyboardType = .decimalPad
        textField.font = .overpassMedium17
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        return textField
    }()
    
    private let flashCallButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Flash Call", for: .normal)
        button.setTitleColor(UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1), for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.titleLabel?.font = .overpassBold17
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1).cgColor
        return button
    }()
    
    private let smsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("SMS", for: .normal)
        button.setTitleColor(UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1), for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.titleLabel?.font = .overpassBold17
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1).cgColor
        return button
    }()
    
    private let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
        phonenumberTextField.delegate = self
        addTargets()
        addKeyboardObservers()
    }
    
    private func configureUI() {
        title = "Телефон"
        view.backgroundColor = .white
    }
    
    private func addTargets() {
        flashCallButton.addTarget(self, action: #selector(sendFlashCall), for: .touchDown)
        smsButton.addTarget(self, action: #selector(sendSMS), for: .touchDown)
    }
    
    private func addKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func setupLayout() {
        view.addSubview(phonenumberTextField)
        view.addSubview(phoneLabel)
        buttonStack.addArrangedSubview(flashCallButton)
        buttonStack.addArrangedSubview(smsButton)
        view.addSubview(buttonStack)
        bottomButtonConstraint = buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            phonenumberTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            phonenumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            phonenumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phonenumberTextField.heightAnchor.constraint(equalToConstant: 50),
            
            phoneLabel.bottomAnchor.constraint(equalTo: phonenumberTextField.topAnchor, constant: -5),
            phoneLabel.leadingAnchor.constraint(equalTo: phonenumberTextField.leadingAnchor),
            
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomButtonConstraint,
            buttonStack.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func sendFlashCall() {
        smsButton.isSelected = false
        flashCallButton.isSelected = true
        flashCallButton.backgroundColor = UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1)
        smsButton.backgroundColor = .white
        guard let inputNumber = phonenumberTextField.text else { return }
        let digitsCount = inputNumber.compactMap{ $0.wholeNumberValue }
        guard digitsCount.count == 10 else { return }
        var code = ""
        ChangePhonenumberNetworkManager.confirmationRequest(requestType: .flashCall, inputNumber: inputNumber) { stringData, stringCode in
            code = stringCode
            print(code)
            let vc = ConfirmationCodeEnterConfigurator.configureWith(phoneNumber: inputNumber, confirmationCode: code, requestType: .flashCall)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func sendSMS() {
        flashCallButton.isSelected = false
        smsButton.isSelected = true
        smsButton.backgroundColor = UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1)
        flashCallButton.backgroundColor = .white
        guard let inputNumber = phonenumberTextField.text else { return }
        let digitsCount = inputNumber.compactMap{ $0.wholeNumberValue }
        guard digitsCount.count == 10 else { return }
        var code = ""
        ChangePhonenumberNetworkManager.confirmationRequest(requestType: .sms, inputNumber: inputNumber) { stringData, stringCode in
            code = stringCode
            print(code)
            let vc = ConfirmationCodeEnterConfigurator.configureWith(phoneNumber: inputNumber, confirmationCode: code, requestType: .sms)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            bottomButtonConstraint.constant = -16
        } else {
            let height = keyboardViewEndFrame.height
            bottomButtonConstraint.constant = -height
            view.layoutIfNeeded()
        }
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1).cgColor
        textField.layer.borderWidth = 2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var fullString = textField.text ?? ""
        fullString.append(string)
        if range.length == 1 {
            textField.text = viewModel.format(phoneNumber: fullString, shouldRemoveLastDigit: true)
        } else {
            textField.text = viewModel.format(phoneNumber: fullString, shouldRemoveLastDigit: nil)
        }
        return false
    }
}
