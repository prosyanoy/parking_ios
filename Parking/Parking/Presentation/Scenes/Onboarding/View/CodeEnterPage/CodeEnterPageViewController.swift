//
//  CodeEnterPageViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов and Denis Zagudaev on 11.09.2022.
//

import UIKit

final class CodeEnterPageViewController: UIViewController {
    
    var viewModel: CodeEnterPageViewModelProtocol
    weak var delegate: PageViewControllerDelegate?
    
    init(viewModel: CodeEnterPageViewModelProtocol, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var timerDisplay = 60
    private var timer = Timer()
    
    let imageView: UIImageView = {
        let iw = UIImageView(image: UIImage(named: "ellipse"))
        iw.translatesAutoresizingMaskIntoConstraints = false
        iw.contentMode = .scaleAspectFill
        return iw
    }()
    let wellcomLable: UILabel = {
        let lable = UILabel()
        lable.text = "Добро пожаловать!"
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
        lable.numberOfLines = 2
        lable.textAlignment = .left
        lable.font = UIFont.boldSystemFont(ofSize: 50)
        return lable
    }()
    private let confirmationMethodSwitcher: UISegmentedControl = {
        let titles = ["Flash call", "SMS"]
        let segmentedControl = UISegmentedControl(items: titles)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = 25
        segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 0.5607843137, green: 0.4274509804, blue: 0.8470588235, alpha: 1)
        return segmentedControl
    }()
    private var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    private let codeConfirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Запросить код", for: .normal)
        button.setTitleColor(UIColor(
            red: 0.5607843137,
            green: 0.4274509804,
            blue: 0.8470588235,
            alpha: 1
        ), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        return button
    }()
    private let codeTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textContentType = .oneTimeCode
        textfield.textAlignment = .center
        textfield.textColor = #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)
        textfield.font = UIFont.boldSystemFont(ofSize: 40)
        textfield.attributedPlaceholder = NSAttributedString(
            string: "• • • •",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(
                red: 0.5607843137,
                green: 0.4274509804,
                blue: 0.8470588235,
                alpha: 1
            )]
        )
        if let text = textfield.text {
            textfield.text = text.applyPatternOnNumbersPhone(pattern: "# # # #", replacementCharacter: "#")
        }
        textfield.keyboardType = .decimalPad
        textfield.layer.cornerRadius = 10
        return textfield
    }()
    private let descriptionLabel: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Вам поступит звонок, введите последние 4 цифры номера"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        view.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
        print(viewModel.inputNumber)
        setDelegates()
        setTargets()
        codeTextField.isHidden = true
        descriptionLabel.isHidden = true
    }
    
   
    
    private func setDelegates() {
        codeTextField.delegate = self
    }
    
    private func setTargets() {
        confirmationMethodSwitcher.addTarget(self, action: #selector(confirmationMethodSwitch(_:)), for: .valueChanged)
        codeConfirmButton.addTarget(self, action: #selector(sendConfirmationCode(_:)), for: .touchUpInside)
    }
    
    @objc func confirmationMethodSwitch(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            descriptionLabel.text = "Введите последние 4 цифры входящего номера"
        case 1:
            descriptionLabel.text = "Введите код из SMS"
        default:
            descriptionLabel.text = ""
        }
    }
    
    @objc func timerAction(){
        timerDisplay -= 1
        timerLabel.text = "Запросить код повторно можно через \(timerDisplay) секунд"
        if timerDisplay == 0 {
            timer.invalidate()
            timerLabel.isHidden = true
            codeConfirmButton.isHidden = false
            timerDisplay = 60
        } else {
            codeConfirmButton.isHidden = true
            timerLabel.isHidden = false
        }
    }
    
    @objc func sendConfirmationCode(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        codeTextField.isHidden = false
        descriptionLabel.isHidden = false
        let switchIndex = confirmationMethodSwitcher.selectedSegmentIndex
        var smsId = ""
        var code = ""
        if switchIndex == 0 {
            viewModel.confirmationByCallRequest(inputNumber: viewModel.inputNumber) { stringData in
                smsId = stringData
                print(stringData)
            }
        } else {
            viewModel.confirmationBySMSRequest(inputNumber: viewModel.inputNumber) { stringData, stringCode in
                code = stringCode
                print(stringCode)
                print(stringData)
            }
        }
        viewModel.checkResponseSMSid(stringData: smsId)
    }
}

extension CodeEnterPageViewController {

    func setupLayout() {
        
        view.addSubview(imageView)
        view.addSubview(wellcomLable)
        view.addSubview(confirmationMethodSwitcher)
        view.addSubview(codeConfirmButton)
        view.addSubview(codeTextField)
        view.addSubview(descriptionLabel)
        view.addSubview(timerLabel)
        imageView.addSubview(wellcomLable)
        timerLabel.isHidden = true
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wellcomLable.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 40),
            wellcomLable.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 24),
            wellcomLable.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -24),
            confirmationMethodSwitcher.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            confirmationMethodSwitcher.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            confirmationMethodSwitcher.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            confirmationMethodSwitcher.widthAnchor.constraint(equalToConstant: 300),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.topAnchor.constraint(equalTo: confirmationMethodSwitcher.bottomAnchor, constant: 40),
            timerLabel.widthAnchor.constraint(equalToConstant: 300),
            timerLabel.heightAnchor.constraint(equalToConstant: 40),
            codeConfirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeConfirmButton.topAnchor.constraint(equalTo: confirmationMethodSwitcher.bottomAnchor, constant: 40),
            codeConfirmButton.widthAnchor.constraint(equalToConstant: 300),
            codeConfirmButton.heightAnchor.constraint(equalToConstant: 40),
            codeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeTextField.topAnchor.constraint(equalTo: codeConfirmButton.bottomAnchor, constant: 40),
            codeTextField.widthAnchor.constraint(equalToConstant: 200),
            codeTextField.heightAnchor.constraint(equalToConstant: 40),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 40),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 200),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

extension CodeEnterPageViewController: UITextFieldDelegate {
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
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)\\,]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: r, withTemplate: "")

        if number.count > 4 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 4)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }

        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }

        switch number.count {
        case 1:
            let end = number.index(number.startIndex, offsetBy: number.count)
                       let range = number.startIndex..<end
                       number = number.replacingOccurrences(of: "(\\d{1})", with: "$1 ", options: .regularExpression, range: range)
        case 2:
            let end = number.index(number.startIndex, offsetBy: number.count)
                       let range = number.startIndex..<end
                       number = number.replacingOccurrences(of: "(\\d{1})(\\d{1})", with: "$1 $2 ", options: .regularExpression, range: range)
        case 3:
            let end = number.index(number.startIndex, offsetBy: number.count)
                       let range = number.startIndex..<end
                       number = number.replacingOccurrences(of: "(\\d{1})(\\d{1})(\\d{1})", with: "$1 $2 $3 ", options: .regularExpression, range: range)
        case 4:
            let end = number.index(number.startIndex, offsetBy: number.count)
                       let range = number.startIndex..<end
                       number = number.replacingOccurrences(of: "(\\d{1})(\\d{1})(\\d{1})(\\d{1})", with: "$1 $2 $3 $4", options: .regularExpression, range: range)
        default:
            break
        }
        return number
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let code = text.removeAllSapce
        let value = viewModel.checkConfirmationSmsCode(inputCode: code)
            if value {
                let defaults = UserDefaults.standard
                defaults.set(viewModel.inputNumber, forKey: "userPhoneNumber")
                defaults.set(true, forKey: "isPhoneSaved\(viewModel.inputNumber)")
                let phone = defaults.string(forKey: "userPhoneNumber") ?? ""
                print(phone)
                dismiss(animated: true)
            } else {
//                textField
            }
    }
   
}

extension String {
    func applyPatternOnCodeNumbersPhone(pattern: String, replacementCharacter: Character) -> String {
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
    
    var removeAllSapce: String {
           return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
       }

}
