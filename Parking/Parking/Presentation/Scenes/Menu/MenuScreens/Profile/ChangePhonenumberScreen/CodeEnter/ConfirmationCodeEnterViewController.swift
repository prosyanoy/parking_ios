//
//  ConfirmationCodeEnterViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 30.09.2022.
//

import Foundation
import UIKit

final class ConfirmationCodeEnterViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel: ConfirmationCodeEnterViewModelProtocol
    var counter: Double = 90
    var inputCode = ""
    
    init(viewModel: ConfirmationCodeEnterViewModelProtocol, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let codeTextFieldFirst: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textContentType = .oneTimeCode
        textfield.textAlignment = .center
        textfield.keyboardType = .decimalPad
        textfield.layer.cornerRadius = 10
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.tag = 1
        
        return textfield
    }()
    
    private let codeTextFieldSecond: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textContentType = .oneTimeCode
        textfield.textAlignment = .center
        textfield.keyboardType = .decimalPad
        textfield.layer.cornerRadius = 10
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.tag = 2
        return textfield
    }()
    
    private let codeTextFieldThird: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textContentType = .oneTimeCode
        textfield.textAlignment = .center
        textfield.keyboardType = .decimalPad
        textfield.layer.cornerRadius = 10
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.tag = 3
        return textfield
    }()
    
    private let codeTextFieldFourth: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textContentType = .oneTimeCode
        textfield.textAlignment = .center
        textfield.keyboardType = .decimalPad
        textfield.layer.cornerRadius = 10
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.tag = 4
        return textfield
    }()
    
    private let codeStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let wrongCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Неверный код"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        return label
    }()
    
    private let countdownButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.setTitle("Отправить повторно", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .disabled)
        button.setTitleColor(UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Введите код"
        view.backgroundColor = .white
        setDelegates()
        setupLayout()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        countdownButton.addTarget(self, action: #selector(repeatRequest), for: .touchUpInside)
    }
    
    private func setDelegates() {
        codeTextFieldFirst.delegate = self
        codeTextFieldSecond.delegate = self
        codeTextFieldThird.delegate = self
        codeTextFieldFourth.delegate = self
    }
    
    private func setupLayout() {
        codeStackView.addArrangedSubview(codeTextFieldFirst)
        codeStackView.addArrangedSubview(codeTextFieldSecond)
        codeStackView.addArrangedSubview(codeTextFieldThird)
        codeStackView.addArrangedSubview(codeTextFieldFourth)
        view.addSubview(codeStackView)
        view.addSubview(wrongCodeLabel)
        view.addSubview(countdownButton)
        
        NSLayoutConstraint.activate([
            
            codeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            codeStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            codeStackView.widthAnchor.constraint(equalToConstant: 200),
            codeStackView.heightAnchor.constraint(equalToConstant: 50),
            
            wrongCodeLabel.topAnchor.constraint(equalTo: codeStackView.bottomAnchor, constant: 16),
            wrongCodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            countdownButton.topAnchor.constraint(equalTo: wrongCodeLabel.bottomAnchor, constant: 2),
            countdownButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
        ])
    }
    
    @objc func updateCounter() {
        if counter > 0 {
            countdownButton.setTitle("Отправить повторно через \(formatCounter(counter: counter))", for: .disabled)
            counter -= 1
        } else {
            countdownButton.isEnabled = true
        }
    }
    
    @objc func repeatRequest() {
        ChangePhonenumberNetworkManager.confirmationRequest(requestType: viewModel.requestType, inputNumber: viewModel.inputNumber) { [unowned self] data, code in
            self.viewModel.confirmationCode = code
        }
        counter = 90
    }
    
    func formatCounter(counter: Double) -> String {
        let minutes = Int((counter/60).truncatingRemainder(dividingBy: 60))
        let seconds = Int(counter.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
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
        if string != "" {
            
            if textField.text == "" {
                textField.text = string
                inputCode.append(contentsOf: string)
                
                if textField == codeTextFieldFourth {
                    textField.resignFirstResponder()
                    if viewModel.checkConfirmationCode(inputCode: inputCode) {
                        UserDefaultsDataManager.userPhoneNumber = viewModel.inputNumber
                        self.navigationController?.popToRootViewController(animated: true)
                    } else {
                        self.wrongCodeLabel.isHidden = false
                    }
                }
                let nextResponder: UIResponder? = view.viewWithTag(textField.tag + 1)
                
                if nextResponder != nil {
                    nextResponder?.becomeFirstResponder()
                }
            }
            return false
        } else {
            
            textField.text = string
            inputCode.removeLast()
            let nextResponder: UIResponder? = view.viewWithTag(textField.tag - 1)
            if nextResponder != nil {
                nextResponder?.becomeFirstResponder()
            }
            return false
        }
    }
}
