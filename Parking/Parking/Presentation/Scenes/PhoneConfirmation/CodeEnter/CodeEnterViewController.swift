//
//  CodeEnterViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 25.08.2022.
//

import UIKit

final class CodeEnterViewController: UIViewController, UITextFieldDelegate {
    
    let viewModel: CodeEnterViewModelProtocol
    
    init(phoneNumber: String, confirmationCode: String, viewModel: CodeEnterViewModelProtocol, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        titleLabel.text = "+7 \(viewModel.inputNumber)"
        setupLayout()
        setDelegates()
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .black
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private lazy var codeTextfieldFirst: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textContentType = .oneTimeCode
        textfield.tag = 0
        textfield.borderStyle = .bezel
        textfield.keyboardType = .decimalPad
        textfield.textAlignment = .center
        return textfield
    }()
    
    private let codeTextfieldSecond: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textContentType = .oneTimeCode
        textfield.tag = 1
        textfield.borderStyle = .bezel
        textfield.keyboardType = .decimalPad
        textfield.textAlignment = .center
        return textfield
    }()
    
    private let codeTextfieldThird: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textContentType = .oneTimeCode
        textfield.tag = 2
        textfield.borderStyle = .bezel
        textfield.keyboardType = .decimalPad
        textfield.textAlignment = .center
        return textfield
    }()
    
    private let codeTextfieldFour: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textContentType = .oneTimeCode
        textfield.tag = 3
        textfield.borderStyle = .bezel
        textfield.keyboardType = .decimalPad
        textfield.textAlignment = .center
        return textfield
    }()
    
    private let codeTextfieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setDelegates() {
        codeTextfieldFirst.delegate = self
        codeTextfieldSecond.delegate = self
        codeTextfieldThird.delegate = self
        codeTextfieldFour.delegate = self
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        
        codeTextfieldStackView.addArrangedSubview(codeTextfieldFirst)
        codeTextfieldStackView.addArrangedSubview(codeTextfieldSecond)
        codeTextfieldStackView.addArrangedSubview(codeTextfieldThird)
        codeTextfieldStackView.addArrangedSubview(codeTextfieldFour)
        view.addSubview(codeTextfieldStackView)
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            codeTextfieldStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeTextfieldStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            
        ])
    }
    
    private func checkConfirmationCode() {
        
    }
    
    //MARK: - Textfield Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string != "") {
            
            if (textField.text == "") {
                textField.text = string
                let nextResponder: UIResponder? = view.viewWithTag(textField.tag + 1)
                if (nextResponder != nil) {
                    nextResponder?.becomeFirstResponder()
                }
            }
            return false
        } else {
            
            textField.text = string
            
            let nextResponder: UIResponder? = view.viewWithTag(textField.tag - 1)
            if (nextResponder != nil) {
                nextResponder?.becomeFirstResponder()
            }
            return false
        }
    }
}
