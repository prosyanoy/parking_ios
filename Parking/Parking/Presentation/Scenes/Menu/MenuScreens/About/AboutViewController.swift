//
//  AboutViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 16.08.2022.
//
import Foundation
import UIKit

final class AboutViewController: UIViewController {
    
    private let viewModel: AboutViewModelProtocol
    
    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let appTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Parking"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Версия \(appVersion ?? "").\(build ?? "")"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let callCenterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Единый контакт - центр"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let callCenterNumberTextView: UITextView = {
        let view = UITextView()
        let text = "+7 999 999 9999"
        let attributedString = NSMutableAttributedString(string: text)
        if let url = URL(string: "tel://+79999999999") {
            attributedString.setAttributes([.link: url], range: (attributedString.string as NSString).range(of: text))
        }
        view.attributedText = attributedString
        view.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        view.isUserInteractionEnabled = true
        view.isEditable = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataDetectorTypes = .link
        view.font = .systemFont(ofSize: 14)
        view.textColor = .systemBlue
        view.isScrollEnabled = false
        return view
    }()
    
    private let instructionsButton: UIButton = {
        let payButton = UIButton()
        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.backgroundColor = .systemBlue
        payButton.setTitle("Инструкция", for: .normal)
        payButton.titleLabel?.font = .systemFont(ofSize: 14)
        payButton.setTitleColor( UIColor.white, for: .normal)
        payButton.layer.cornerRadius = 10
        payButton.contentHorizontalAlignment = .center
        return payButton
    }()
    
    private let moreButton: UIButton = {
        let payButton = UIButton()
        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.backgroundColor = .systemBlue
        payButton.setTitle("Подробнее", for: .normal)
        payButton.titleLabel?.font = .systemFont(ofSize: 14)
        payButton.setTitleColor( UIColor.white, for: .normal)
        payButton.layer.cornerRadius = 10
        payButton.contentHorizontalAlignment = .center
        return payButton
    }()
    
    private let termsOfServiceLinkTextView: UITextView = {
        let view = UITextView()
        let text = "Условия использования сервиса Яндекс.Карт"
        let attributedString = NSMutableAttributedString(string: text)
        if let url = URL(string: "https://yandex.ru/legal/maps_termsofuse/") {
            attributedString.setAttributes([.link: url], range: (attributedString.string as NSString).range(of: text))
        }
        view.attributedText = attributedString
        view.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        view.isUserInteractionEnabled = true
        view.isEditable = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataDetectorTypes = .link
        view.font = .systemFont(ofSize: 14)
        view.textColor = .systemBlue
        view.isScrollEnabled = false
        return view
    }()
    
    private let policyLinkTextView: UITextView = {
        let view = UITextView()
        let text = "Условия пользовательского соглашения"
        let attributedString = NSMutableAttributedString(string: text)
        if let url = URL(string: "http://parking.pros.sbs/policy") {
            attributedString.setAttributes([.link: url], range: (attributedString.string as NSString).range(of: text))
        }
        view.attributedText = attributedString
        view.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        view.isUserInteractionEnabled = true
        view.isEditable = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataDetectorTypes = .link
        view.font = .systemFont(ofSize: 14)
        view.textColor = .systemBlue
        view.isScrollEnabled = false
        return view
    }()
    
    private let personalDataConsentLinkTextView: UITextView = {
        let view = UITextView()
        let text = "Согласие на обработку персональных данных "
        let attributedString = NSMutableAttributedString(string: text)
        if let url = URL(string: "http://parking.pros.sbs/pdata") {
            attributedString.setAttributes([.link: url], range: (attributedString.string as NSString).range(of: text))
        }
        view.attributedText = attributedString
        view.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        view.isUserInteractionEnabled = true
        view.isEditable = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataDetectorTypes = .link
        view.font = .systemFont(ofSize: 14)
        view.textColor = .systemBlue
        view.isScrollEnabled = false
        return view
    }()
    
    init(viewModel: AboutViewModelProtocol, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        view.backgroundColor = .white
        title = "О приложении"
        setupLayout()
        setDelegates()
        addTargets()
    }
    
    private func setDelegates() {
        callCenterNumberTextView.delegate = self
        termsOfServiceLinkTextView.delegate = self
        policyLinkTextView.delegate = self
        personalDataConsentLinkTextView.delegate = self
    }
    
    private func addTargets() {
        instructionsButton.addTarget(self, action: #selector(instructionsButtonTapped(_ :)), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(moreButtonTapped(_ :)), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(logo)
        view.addSubview(appTitle)
        view.addSubview(versionLabel)
        view.addSubview(callCenterLabel)
        view.addSubview(callCenterNumberTextView)
        view.addSubview(instructionsButton)
        view.addSubview(moreButton)
        view.addSubview(termsOfServiceLinkTextView)
        view.addSubview(policyLinkTextView)
        view.addSubview(personalDataConsentLinkTextView)
        
        NSLayoutConstraint.activate([
            
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logo.heightAnchor.constraint(equalToConstant: 100),
            logo.widthAnchor.constraint(equalTo: logo.heightAnchor),
            
            appTitle.topAnchor.constraint(equalTo: logo.topAnchor),
            appTitle.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 16),
            
            versionLabel.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 16),
            versionLabel.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 16),
            
            callCenterLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 30),
            callCenterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            callCenterNumberTextView.topAnchor.constraint(equalTo: callCenterLabel.bottomAnchor),
            callCenterNumberTextView.leadingAnchor.constraint(equalTo: callCenterLabel.leadingAnchor),
            
            instructionsButton.topAnchor.constraint(equalTo: callCenterNumberTextView.bottomAnchor, constant: 30),
            instructionsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            instructionsButton.widthAnchor.constraint(equalTo: callCenterNumberTextView.widthAnchor),
            instructionsButton.heightAnchor.constraint(equalToConstant: 30),
            
            moreButton.topAnchor.constraint(equalTo: instructionsButton.bottomAnchor, constant: 16),
            moreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            moreButton.widthAnchor.constraint(equalTo: callCenterNumberTextView.widthAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 30),
            
            termsOfServiceLinkTextView.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 16),
            termsOfServiceLinkTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            policyLinkTextView.topAnchor.constraint(equalTo: termsOfServiceLinkTextView.bottomAnchor, constant: 16),
            policyLinkTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            personalDataConsentLinkTextView.topAnchor.constraint(equalTo: policyLinkTextView.bottomAnchor, constant: 16),
            personalDataConsentLinkTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    @objc private func instructionsButtonTapped(_ sender: UIButton) {
        print("instructionsButtonTapped")
    }
    
    @objc private func moreButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "http://parking.pros.sbs") {
            UIApplication.shared.open(url)
        }
    }
}

extension AboutViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith url: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if url.scheme == "tel" {
            let phone = url.absoluteString.replacingOccurrences(of: "tel:", with: "")
            
            if let callUrl = URL(string: "tel:\(phone)"), UIApplication.shared.canOpenURL(callUrl) {
                UIApplication.shared.open(callUrl)
            }
        }
        return true
    }
}
