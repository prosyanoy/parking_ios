//
//  WalletPaymentViewController.swift
//  Parking
//
//  Created by Maxim Terpugov on 16.08.2022.
//

import UIKit


final class WalletPaymentViewController: UIViewController,
                                         UITextFieldDelegate {
    
    // MARK: - Dependencies
    
    private let viewModel: WalletPaymentViewModelProtocol
    
    
    // MARK: - Init
    
    init(viewModel: WalletPaymentViewModelProtocol,
         nibName nibNameOrNil: String? = nil,
         bundle nibBundleOrNil: Bundle? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Input data flow
    
    private func setupObservers() {
        viewModel.selectedPaymentMethod.subscribe(observer: self) { [weak self] paymentMethod in
            self?.paymentMethodView.setContent(title: paymentMethod.title,
                                               description: paymentMethod.description,
                                               icon: nil)
        }
        viewModel.isLoading.subscribe(observer: self) { [weak self] isLoading in
            switch isLoading {
            case true:
                self?.activity.startAnimating()
                self?.payButton.isEnabled = false
            case false:
                self?.activity.stopAnimating()
                self?.payButton.isEnabled = true
            }
        }
    }
    
    private lazy var minimumAmount: Int = {
        let amount = self.viewModel.minimumPaymentAmount
        return amount
    }()
    
    
    // MARK: - View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialUI()
        setupNavigationBar()
        setupLayout()
        setupObservers()
        viewModel.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activity.center = CGPoint(x: paymentMethodView.frame.width / 2,
                                  y: paymentMethodView.frame.height / 2)
    }
    
    
    // MARK: - UI
    
    private func setupInitialUI() {
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Пополнить счет"
        navigationItem.setLeftBarButton(
            UIBarButtonItem(title: "Отмена",
                            style: .plain,
                            target: self,
                            action: #selector(cancelButtonTapped)),
            animated: false)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true,
                completion: nil)
    }
    
    private lazy var paymentAmountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = String(minimumAmount)
        textField.text = String(minimumAmount)
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 32, weight: .regular)
        textField.borderStyle = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .numberPad
        textField.keyboardAppearance = .light
        textField.clearButtonMode = .never
        textField.contentVerticalAlignment = .center
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.inputAccessoryView = numberToolbar
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var currencyTrailingPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "₽"
        label.font = .systemFont(ofSize: 32, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [paymentAmountTextField,
                                                   currencyTrailingPlaceholder])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 1
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomPlaceholder: UILabel = {
        let label = UILabel()
        label.text = "Баланс после пополнения \(minimumAmount)\u{2006}₽"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black.withAlphaComponent(0.7)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var paymentMethodPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Способ оплаты"
        label.font = .systemFont(ofSize: 13, weight: .thin)
        label.textColor = .black.withAlphaComponent(0.8)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var paymentMethodView: PaymentMethodView = {
        let view = PaymentMethodView(frame: .zero)
        view.addTarget(self,
                       action: #selector(paymentMethodViewTapped),
                       for: .touchUpInside)
        view.layer.borderColor = #colorLiteral(red: 0, green: 0.7409000993, blue: 0.9917448163, alpha: 1).cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc private func paymentMethodViewTapped() {
        viewModel.paymentMethodViewTapped()
    }
    
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Обратите внимание на комиссию внешних сервисов"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 4
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numberToolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0,
                                              width: view.bounds.width, height: 35))
        toolbar.barTintColor = #colorLiteral(red: 0.8182896972, green: 0.8312941194, blue: 0.8559113741, alpha: 1)
        toolbar.isTranslucent = false
        toolbar.sizeToFit()
        
        let button50 = UIButton(type: .system)
        button50.frame = CGRect(x: 0, y: 0, width: 50, height: 15)
        button50.setTitle("50", for: .normal)
        button50.setTitleColor(.black, for: .normal)
        button50.backgroundColor = .white
        button50.layer.cornerRadius = 4.0
        button50.layer.masksToBounds = true
        button50.addTarget(self, action: #selector(fiftyButtonTapped), for: .touchUpInside)
        
        let button100 = UIButton(type: .system)
        button100.frame = CGRect(x: 0, y: 0, width: 50, height: 15)
        button100.setTitle("100", for: .normal)
        button100.setTitleColor(.black, for: .normal)
        button100.backgroundColor = .white
        button100.layer.cornerRadius = 4.0
        button100.layer.masksToBounds = true
        button100.addTarget(self, action: #selector(hundredButtonTapped), for: .touchUpInside)
        
        let button300 = UIButton(type: .system)
        button300.frame = CGRect(x: 0, y: 0, width: 50, height: 15)
        button300.setTitle("300", for: .normal)
        button300.setTitleColor(.black, for: .normal)
        button300.backgroundColor = .white
        button300.layer.cornerRadius = 4.0
        button300.layer.masksToBounds = true
        button300.addTarget(self, action: #selector(threeHundredButtonTapped), for: .touchUpInside)
        
        let button500 = UIButton(type: .system)
        button500.frame = CGRect(x: 0, y: 0, width: 50, height: 15)
        button500.setTitle("500", for: .normal)
        button500.setTitleColor(.black, for: .normal)
        button500.backgroundColor = .white
        button500.layer.cornerRadius = 4.0
        button500.layer.masksToBounds = true
        button500.addTarget(self, action: #selector(fiveHundredButtonTapped), for: .touchUpInside)
        
        let button1000 = UIButton(type: .system)
        button1000.frame = CGRect(x: 0, y: 0, width: 50, height: 15)
        button1000.setTitle("1000", for: .normal)
        button1000.setTitleColor(.black, for: .normal)
        button1000.backgroundColor = .white
        button1000.layer.cornerRadius = 4.0
        button1000.layer.masksToBounds = true
        button1000.addTarget(self, action: #selector(thousandButtonTapped), for: .touchUpInside)
        
        toolbar.items = [
            UIBarButtonItem(customView: button50),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(customView: button100),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(customView: button300),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(customView: button500),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(customView: button1000),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(doneButtonTapped))]
        
        return toolbar
    }()
    
    @objc private func doneButtonTapped() {
        guard let text = paymentAmountTextField.text else { return }
        let intText = Int(text)
        if text.isEmpty || (intText != nil && intText! <= minimumAmount) {
            let strMinimumAmount = String(minimumAmount)
            paymentAmountTextField.text = strMinimumAmount
            handlePaymentAmountBottomPlaceholder(strMinimumAmount)
            viewModel.newPaymentAmountSelected(minimumAmount)
        } else if intText != nil && intText! > minimumAmount {
            viewModel.newPaymentAmountSelected(intText!)
        }
        paymentAmountTextField.resignFirstResponder()
    }
    
    @objc private func fiftyButtonTapped() {
        paymentAmountTextField.text = "50"
        viewModel.newPaymentAmountSelected(50)
        handlePaymentAmountBottomPlaceholder("50")
    }
    
    @objc private func hundredButtonTapped() {
        paymentAmountTextField.text = "100"
        viewModel.newPaymentAmountSelected(100)
        handlePaymentAmountBottomPlaceholder("100")
    }
    
    @objc private func threeHundredButtonTapped() {
        paymentAmountTextField.text = "300"
        viewModel.newPaymentAmountSelected(300)
        handlePaymentAmountBottomPlaceholder("300")
    }
    
    @objc private func fiveHundredButtonTapped() {
        paymentAmountTextField.text = "500"
        viewModel.newPaymentAmountSelected(500)
        handlePaymentAmountBottomPlaceholder("500")
    }
    
    @objc private func thousandButtonTapped() {
        paymentAmountTextField.text = "1000"
        viewModel.newPaymentAmountSelected(1000)
        handlePaymentAmountBottomPlaceholder("1000")
    }
    
    private lazy var payButton: UIButton = {
        let button = ScaleButton(type: .system)
        button.setTitle("Оплатить",
                        for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16,
                                                    weight: .semibold)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0, green: 0.7409000993, blue: 0.9917448163, alpha: 1)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func payButtonTapped() {
        viewModel.payButtonTapped()
    }
    
    private lazy var activity: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        indicator.color = .systemGray
        return indicator
    }()
    
    
    // MARK: - Layout
    
    private func setupLayout() {
        view.addSubview(horizontalStack)
        view.addSubview(separatorLine)
        view.addSubview(bottomPlaceholder)
        view.addSubview(paymentMethodPlaceholderLabel)
        view.addSubview(paymentMethodView)
        view.addSubview(warningLabel)
        view.addSubview(payButton)
        paymentMethodView.addSubview(activity)
        
        horizontalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        horizontalStack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 40).isActive = true
        horizontalStack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -40).isActive = true
        horizontalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        
        separatorLine.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 1).isActive = true
        separatorLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        separatorLine.widthAnchor.constraint(equalToConstant: 170).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        bottomPlaceholder.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 5).isActive = true
        bottomPlaceholder.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomPlaceholder.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 40).isActive = true
        bottomPlaceholder.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -40).isActive = true
        
        paymentMethodPlaceholderLabel.topAnchor.constraint(equalTo: bottomPlaceholder.bottomAnchor, constant: 40).isActive = true
        paymentMethodPlaceholderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        paymentMethodPlaceholderLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -25).isActive = true
        
        paymentMethodView.topAnchor.constraint(equalTo: paymentMethodPlaceholderLabel.bottomAnchor, constant: 5).isActive = true
        paymentMethodView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        paymentMethodView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        paymentMethodView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        paymentMethodView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        warningLabel.topAnchor.constraint(equalTo: paymentMethodView.bottomAnchor, constant: 15).isActive = true
        warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        warningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        payButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    
    // MARK: - TextField
    
    @objc private func textFieldDidChange() {
        paymentAmountTextField.invalidateIntrinsicContentSize()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
              let textRange = Range(range, in: text) else {
                  return false
              }
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        let validationResult = validatePaymentAmountTextField(updatedText)
        if validationResult {
            handlePaymentAmountBottomPlaceholder(updatedText)
        }
        return validationResult
    }
    
    private func validatePaymentAmountTextField(_ text: String) -> Bool {
        let format = "SELF MATCHES %@"
        let regEx = "[0-9]{0,7}"
        let result = NSPredicate(format: format, regEx).evaluate(with: text)
        return result
    }
    
    private func handlePaymentAmountBottomPlaceholder(_ text: String) {
        if let amount = Int(text) {
            if amount >= minimumAmount {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.groupingSeparator = " "
                let formattedAmount = formatter.string(for: amount) ?? String(amount)
                bottomPlaceholder.text = "Баланс после пополнения \(formattedAmount)\u{2006}₽"
            } else {
                bottomPlaceholder.text = "Минимальная сумма: \(minimumAmount)\u{2006}₽"
            }
        } else if text.isEmpty {
            bottomPlaceholder.text = "Минимальная сумма: \(minimumAmount)\u{2006}₽"
        }
    }
    
}
