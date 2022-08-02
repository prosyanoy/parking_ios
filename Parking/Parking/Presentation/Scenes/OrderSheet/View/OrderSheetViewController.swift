//
//  OrderSheetViewController.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.07.2022.
//

import UIKit


final class OrderSheetViewController: UIViewController {
    
    private let transitionDelegate: UIViewControllerTransitioningDelegate
    
    private let parking: Parking
    private let dismissOrderSheetCallback: () -> Void
    
    init(transitionDelegate: UIViewControllerTransitioningDelegate,
         parking: Parking,
         dismissOrderSheetCallback: @escaping () -> Void,
         nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?) {
        self.transitionDelegate = transitionDelegate
        self.parking = parking
        self.dismissOrderSheetCallback = dismissOrderSheetCallback
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(adressLabel)
        view.addSubview(dismissButton)
        view.addSubview(payButton)
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        setupLayout()
        setuplabels(parking: parking)
    }
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus"),
                        for: .disabled)
        button.imageView?.layer.transform = CATransform3DMakeScale(2, 2, 0)
        button.tintColor = .systemGray
        button.isEnabled = false
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func dismissButtonTapped() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    private lazy var payButton: UIButton = {
        let button = ScaleButton()
        button.setTitle("Оплатить",
                        for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16,
                                                    weight: .semibold)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0, green: 0.7409000993, blue: 0.9917448163, alpha: 1)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func payButtonTapped() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.alwaysBounceVertical = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Стоимость парковки"
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.text = "Адрес парковки"
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private func setupLayout() {
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
        scrollView.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 5).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 10).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 15).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -10).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        adressLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 15).isActive = true
        adressLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 15).isActive = true
        adressLabel.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -10).isActive = true
        adressLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        payButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        payButton.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        payButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    
    private func setuplabels(parking: Parking) {
        priceLabel.text = "Стоимость парковки:  \(String(parking.hourCost))"
        adressLabel.text = "Адрес парковки: \(parking.adress)"
    }
    
    deinit {
        dismissOrderSheetCallback()
        print("Order Sheet is deinit")
    }
}



