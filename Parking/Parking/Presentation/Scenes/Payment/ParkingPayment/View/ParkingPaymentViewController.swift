//
//  ParkingPaymentViewController.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.08.2022.
//

import UIKit


final class ParkingPaymentViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private let viewModel: ParkingPaymentViewModelProtocol
    
    
    // MARK: - Init
    
    init(viewModel: ParkingPaymentViewModelProtocol,
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
        viewModel.paidParking.subscribe(observer: self) { [weak self] parking in
            self?.setOrderContent(licencePlate: user.value.licencePlate,
                                  parkingTitle: parking.adress,
                                  time: "1 час",
                                  // TODO: Создать новую сущность - Order
                                  price: "\(parking.hourCost)\u{2006}₽")
        }
        
        viewModel.selectedPaymentMethod.subscribe(observer: self) { [weak self] method in
            self?.setPaymenMethodtContent(title: method.title,
                                          description: method.description)
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
    
    private func setOrderContent(licencePlate: String,
                                 parkingTitle: String,
                                 time: String,
                                 price: String) {
        descriptionAutoLabel.text = licencePlate
        descriptionParkingLabel.text = parkingTitle
        descriptionTimeLabel.text = time
        descriptionPriceLabel.text = price
    }
    
    private func setPaymenMethodtContent(title: String,
                                         description: String) {
        paymentMethodView.setContent(title: title,
                                     description: description,
                                     icon: nil)
    }
    
    
    // MARK: - View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInititalUI()
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
    
    private func setupInititalUI() {
        view.backgroundColor = .white
    }
    
    
    // MARK: - UI
    
    private func setupNavigationBar() {
        navigationItem.title = "Оплата парковки"
        navigationItem.setLeftBarButton(
            UIBarButtonItem(title: "Отмена",
                            style: .plain,
                            target: self,
                            action: #selector(cancelButtonTapped)),
            animated: false)
    }
    
    @objc private func cancelButtonTapped() {
        viewModel.cancelButtonTapped()
    }
    
    private lazy var titleAutoLabel: UILabel = {
        let label = UILabel()
        label.text = "Автомобиль"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descriptionAutoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var autoHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleAutoLabel,
                                                   descriptionAutoLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    
    private lazy var titleParkingLabel: UILabel = {
        let label = UILabel()
        label.text = "Парковка"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    
    private lazy var descriptionParkingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 4
        return label
    }()
    
    private lazy var parkingHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleParkingLabel,
                                                   descriptionParkingLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private lazy var titleTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    
    private lazy var descriptionTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var timeHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            autoHorizontalStack,
            titleTimeLabel,
            descriptionTimeLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private lazy var totalVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [autoHorizontalStack,
                                                   parkingHorizontalStack,
                                                   timeHorizontalStack])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.backgroundColor = #colorLiteral(red: 0.8976908326, green: 0.8977413177, blue: 0.918277204, alpha: 1)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titlePriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Стоимость"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descriptionPriceLabel: UILabel = {
        let label = UILabel()
//        label.text = "40 руб."
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var priceHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titlePriceLabel,
                                                   descriptionPriceLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        view.addSubview(totalVerticalStack)
        view.addSubview(priceHorizontalStack)
        view.addSubview(paymentMethodPlaceholderLabel)
        view.addSubview(paymentMethodView)
        view.addSubview(warningLabel)
        view.addSubview(payButton)
        paymentMethodView.addSubview(activity)
        
        totalVerticalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        totalVerticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        totalVerticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        priceHorizontalStack.topAnchor.constraint(equalTo: totalVerticalStack.bottomAnchor, constant: 20).isActive = true
        priceHorizontalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        priceHorizontalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        paymentMethodPlaceholderLabel.topAnchor.constraint(equalTo: priceHorizontalStack.bottomAnchor, constant: 40).isActive = true
        paymentMethodPlaceholderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        paymentMethodPlaceholderLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -25).isActive = true
        
        paymentMethodView.topAnchor.constraint(equalTo: paymentMethodPlaceholderLabel.bottomAnchor, constant: 5).isActive = true
        paymentMethodView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        paymentMethodView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        paymentMethodView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        warningLabel.topAnchor.constraint(equalTo: paymentMethodView.bottomAnchor, constant: 15).isActive = true
        warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        warningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        payButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
}
