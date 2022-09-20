//
//  CityAndPhonePage.swift
//  Parking
//
//  Created by Анатолий Силиверстов and Denis Zagudaev on 11.09.2022.
//

import UIKit

class CityAndPhonePageViewController: UIViewController{
    
    weak var delegate: PageViewControllerDelegate?
    let defaults = UserDefaults.standard
   
    let imageView: UIImageView = {
        let iw = UIImageView(image: UIImage(named: "ellipse"))
        iw.translatesAutoresizingMaskIntoConstraints = false
        iw.contentMode = .scaleAspectFill
        return iw
    }()
    let stackViewCity: UIStackView = {
        let stckView = UIStackView()
        stckView.translatesAutoresizingMaskIntoConstraints = false
        stckView.axis = .vertical
        stckView.spacing = 10
        return stckView
    }()
    let stackViewPhone: UIStackView = {
        let stckView = UIStackView()
        stckView.translatesAutoresizingMaskIntoConstraints = false
        stckView.axis = .vertical
        stckView.spacing = 10
        return stckView
    }()
    let wellcomLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Добро пожаловать!"
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
        lable.numberOfLines = 2
        lable.textAlignment = .left
        lable.font = UIFont.boldSystemFont(ofSize: 50)
        return lable
    }()
    let cityTitleLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Город"
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = #colorLiteral(red: 0.3764705882, green: 0.3764705882, blue: 0.3764705882, alpha: 1)
        lable.textAlignment = .left
        lable.font = .overpassMedium18
        return lable
    }()
    let cityTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Владивосток"
        return textfield
    }()
    
    let phoneTitleLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Номер телефона"
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = #colorLiteral(red: 0.3764705882, green: 0.3764705882, blue: 0.3764705882, alpha: 1)
        lable.textAlignment = .left
        lable.font = .overpassMedium18
        return lable
    }()
    
    let phoneTextField: UITextField = {
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
        textfield.borderStyle = .line
        textfield.layer.borderColor = #colorLiteral(red: 0.2901960784, green: 0.6588235294, blue: 1, alpha: 1)
        if let text = textfield.text {
            textfield.text = text.applyPatternOnNumbersPhone(pattern: "(###) ###-####", replacementCharacter: "#")
        }
        textfield.borderStyle = .none
        return textfield
    }()
    
    let confirmationLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Запросив код, вы принимаете пользовательское соглашение и согласие на обработку персональных данных"
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = #colorLiteral(red: 0.3764705882, green: 0.3764705882, blue: 0.3764705882, alpha: 1)
        lable.numberOfLines = 6
        lable.textAlignment = .center
        lable.font = .overpassMedium16
        return lable
    }()
    
    let chekPhoneNumber: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.5607843137, green: 0.4274509804, blue: 0.8470588235, alpha: 1)
        button.setImage(UIImage(named: "vector"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = 52
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        setupLayout()
        phoneTextField.delegate = self
        cityTextField.delegate = self
        chekPhoneNumber.addTarget(self, action: #selector(chekPhoneNumberTapped(_:)), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as? UITouch {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if defaults.string(forKey: "numberOfCar") != nil {
            print(defaults.string(forKey: "userPhoneNumber") ?? "")
            print(defaults.string(forKey: "numberOfCar") ?? "")
            print(defaults.string(forKey: "typeOfCar") ?? "")
            dismiss(animated: true)
        }
    }
}
extension CityAndPhonePageViewController {

    func setupLayout() {
        view.addSubview(imageView)
        view.addSubview(wellcomLabel)
        view.addSubview(stackViewCity)
        view.addSubview(stackViewPhone)
        view.addSubview(confirmationLabel)
        view.addSubview(chekPhoneNumber)
        imageView.addSubview(wellcomLabel)
        
        stackViewCity.addArrangedSubview(cityTitleLabel)
        stackViewCity.addArrangedSubview(cityTextField)
        stackViewPhone.addArrangedSubview(phoneTitleLabel)
        stackViewPhone.addArrangedSubview(phoneTextField)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wellcomLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 40),
            wellcomLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 24),
            wellcomLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -24),
            stackViewCity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewCity.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackViewCity.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackViewCity.leadingAnchor, multiplier: 2),
            stackViewPhone.topAnchor.constraint(equalTo: stackViewCity.bottomAnchor, constant: 20),
            stackViewPhone.heightAnchor.constraint(equalTo: stackViewCity.heightAnchor),
            stackViewPhone.widthAnchor.constraint(equalTo: stackViewCity.widthAnchor),
            stackViewPhone.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackViewPhone.leadingAnchor, multiplier: 2),
            confirmationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 180),
            confirmationLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: confirmationLabel.leadingAnchor, multiplier: 2),
            chekPhoneNumber.topAnchor.constraint(equalTo: view.topAnchor, constant: 743),
            chekPhoneNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 162),
            chekPhoneNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -162),
            chekPhoneNumber.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -79)
        ])
    }
    
    @objc func chekPhoneNumberTapped(_ sender: UIButton) {
        guard let inputNumber = phoneTextField.text else { return }
        if !defaults.bool(forKey: "isPhoneSaved\(inputNumber)") {
        if inputNumber.count == 14 {
            phoneTextField.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.8666666667, blue: 0.4666666667, alpha: 1)
        let vc = CodeEnterPageConfigurator.configureWith(phoneNumber: inputNumber)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        } else {
            phoneTextField.layer.borderColor = #colorLiteral(red: 0.2901960784, green: 0.6588235294, blue: 1, alpha: 1)
        }
        } else {
//            let vc =  NewCarConfigurator.configure()
            let vc = NewCarViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension CityAndPhonePageViewController: UITextFieldDelegate {
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count == 14 {
            textField.resignFirstResponder()
        }
    }
}

extension String {
    func applyPatternOnNumbersPhone(pattern: String, replacementCharacter: Character) -> String {
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


