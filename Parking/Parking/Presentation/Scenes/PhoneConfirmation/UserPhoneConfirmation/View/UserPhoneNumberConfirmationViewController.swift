//
//  UserPhoneNumberConfirmation.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 22.08.2022.
//

import UIKit

class UserPhoneNumberConfirmationViewController: UIViewController {
    
    private let viewModel: UserPhoneNumberConfirmationViewModelProtocol
    
    init(viewModel: UserPhoneNumberConfirmationViewModelProtocol,
         nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Подтверждение номера телефона для автовладельца"
        label.tintColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .overpassBold17
        return label
    }()
    
    private let confirmationMethodSwitcher: UISegmentedControl = {
        let titles = ["Звонок", "SMS"]
        let segmentedControl = UISegmentedControl(items: titles)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = 20
        segmentedControl.tintColor = .systemBlue
        return segmentedControl
    }()
    
    private let descriptionLabel: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Введите номер телефона. Вам поступит звонок, введите последние 4 цифры номера"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private let phoneNumberTextfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        let leftLabel = UILabel()
        leftLabel.text = "+7 "
        leftLabel.textColor = .black
        leftLabel.font = .overpassMedium17
        textfield.leftView = leftLabel
        textfield.leftViewMode = .always
        textfield.keyboardType = .decimalPad
        textfield.placeholder = "(123) 456-7890"
        textfield.font = .overpassMedium17
        if let text = textfield.text {
            textfield.text = text.applyPatternOnNumbers(pattern: "(###) ###-####", replacementCharacter: "#")
        }
        textfield.borderStyle = .none
        return textfield
    }()
    
    private let textfieldBottomLine: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .red
        return line
    }()
    
    private let warningLabel: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .red
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let skipAuthButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Продолжить без регистрации", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    private let authForOwners: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти как владелец парковки", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setTargets()
        phoneNumberTextfield.delegate = self
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(confirmationMethodSwitcher)
        view.addSubview(descriptionLabel)
        view.addSubview(phoneNumberTextfield)
        view.addSubview(textfieldBottomLine)
        view.addSubview(nextButton)
        view.addSubview(warningLabel)
        view.addSubview(skipAuthButton)
        view.addSubview(authForOwners)
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            confirmationMethodSwitcher.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmationMethodSwitcher.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            confirmationMethodSwitcher.widthAnchor.constraint(equalToConstant: 200),
            
            descriptionLabel.topAnchor.constraint(equalTo: confirmationMethodSwitcher.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            phoneNumberTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneNumberTextfield.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            
            textfieldBottomLine.centerXAnchor.constraint(equalTo: phoneNumberTextfield.centerXAnchor),
            textfieldBottomLine.topAnchor.constraint(equalTo: phoneNumberTextfield.bottomAnchor),
            textfieldBottomLine.widthAnchor.constraint(equalTo: phoneNumberTextfield.widthAnchor, constant: 30),
            textfieldBottomLine.heightAnchor.constraint(equalToConstant: 2),
            
            warningLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warningLabel.topAnchor.constraint(equalTo: phoneNumberTextfield.bottomAnchor, constant: 16),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: phoneNumberTextfield.bottomAnchor, constant: 40),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            
            skipAuthButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skipAuthButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skipAuthButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 30),
            
            authForOwners.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authForOwners.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            authForOwners.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
        ])
    }
    
    private func setTargets() {
        confirmationMethodSwitcher.addTarget(self, action: #selector(confirmationMethodSwitch(_:)), for: .valueChanged)
        nextButton.addTarget(self, action: #selector(sendConfirmationCode(_:)), for: .touchUpInside)
        skipAuthButton.addTarget(self, action: #selector(skipAuthAction(_:)), for: .touchUpInside)
        authForOwners.addTarget(self, action: #selector(getToOwnersScreen(_:)), for: .touchUpInside)
    }
    
    @objc func confirmationMethodSwitch(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            descriptionLabel.text = "Введите номер телефона. Вам поступит звонок, введите последние 4 цифры номера"
        case 1:
            descriptionLabel.text = "Введите номер телефона. Мы отправим код для подтверждения по SMS"
        default:
            descriptionLabel.text = ""
        }
    }
    
    @objc func sendConfirmationCode(_ sender: UIButton) {
        guard let inputNumber = phoneNumberTextfield.text else {return}
        let digitsCount = inputNumber.compactMap{ $0.wholeNumberValue }
        guard digitsCount.count == 10 else { return warningLabel.text = "Номер слишком короткий"}
        let switchIndex = confirmationMethodSwitcher.selectedSegmentIndex
        var smsId = ""
        var code = ""
        if switchIndex == 0 {
            viewModel.confirmationByCallRequest(inputNumber: inputNumber) { stringData in
                smsId = stringData
                print(stringData)
            }
        } else {
            viewModel.confirmationBySMSRequest(inputNumber: inputNumber) { stringData, stringCode in
                code = stringCode
                print(stringCode)
                print(stringData)
                self.present(CodeEnterConfigurator.configureWith(phoneNumber: inputNumber, confirmationCode: code), animated: true)
            }
        }
        viewModel.checkResponseSMSid(stringData: smsId)
    }
    
    @objc func skipAuthAction(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    @objc func getToOwnersScreen(_ sender: UIButton) {
        if let container = presentingViewController as? ContentViewController {
            let parkingOwnersVC = OwnersTabBarController()
            let ownersAuthVC = OwnersPhoneNumberCOnfirmationConfigurator.configure()
            container.removeChildren()
            container.addAndPresent(parkingOwnersVC, presentedController: ownersAuthVC)
            
        }
    }
}

extension UserPhoneNumberConfirmationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var fullString = textField.text ?? ""
        fullString.append(string)
        if range.length == 1 {
            textField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: true)
        } else {
            textField.text = format(phoneNumber: fullString)
        }
        return false
    }
    
    private func format(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        guard !phoneNumber.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: r, withTemplate: "")
        
        if number.count > 10 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 10)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }
        
        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }
        
        if number.count < 7 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "($1) $2", options: .regularExpression, range: range)
            
        } else {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: range)
        }
        
        return number
    }
}

extension String {
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}
