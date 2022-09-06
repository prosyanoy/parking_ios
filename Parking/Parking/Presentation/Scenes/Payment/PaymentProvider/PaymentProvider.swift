//
//  PaymentProvider.swift
//  Parking
//
//  Created by Maxim Terpugov on 24.08.2022.
//

import UIKit
import TinkoffASDKUI
import TinkoffASDKCore


protocol PaymentProviderProtocol {
    func payButtonTapped(method: PaymentMethod.Signature,
                         amount: Int,
                         orderId: String,
                         customerKey: String,
                         email: String,
                         transactionCallback: @escaping (Float) -> Void)
}

protocol PaymentChoiceProviderProtocol {
    func addCardButtonTapped(customerKey: String)
}


final class PaymentProvider: PaymentProviderProtocol,
                             PaymentChoiceProviderProtocol {
    
    // MARK: - Dependencies
    
    private weak var view: UIViewController?
    private var tinkoffSDK: AcquiringUISDK?
    
    
    // MARK: - Init
    
    init() {
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
              let keys = NSDictionary(contentsOfFile: path),
              let terminalKey = keys["TinkoffPaymentTerminalKey"] as? String,
              let publicKey = keys["TinkoffPaymentPublicKey"] as? String else {
            return
        }
        let cred = AcquiringSdkCredential(
            terminalKey: terminalKey,
            publicKey: publicKey
        )
        let sdkConfig = AcquiringSdkConfiguration(credential: cred,
                                                  server: .prod)
        sdkConfig.logger = AcquiringLoggerDefault()
        sdkConfig.showErrorAlert = true
        if let sdk = try? AcquiringUISDK(configuration: sdkConfig) {
            self.tinkoffSDK = sdk
        }
    }
    
    func setupDependencies(view: UIViewController) {
        self.view = view
    }
    
    
    // MARK: - Private
    
    private func format(amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        let formattedAmount = formatter.string(for: amount) ?? String(amount)
        return formattedAmount
    }
    
    
    // MARK: - PaymentProviderProtocol
    
    func addCardButtonTapped(customerKey: String) {
        guard let view = view,
              let sdk = tinkoffSDK else { return }
        // viewConfig VC
        let viewConfig = AcquiringViewConfiguration()
        viewConfig.popupStyle = .bottomSheet
        // present VC
        sdk.presentAddCardView(on: view,
                               customerKey: customerKey,
                               configuration: viewConfig) { result in
        }
    }
    
    func payButtonTapped(method: PaymentMethod.Signature,
                         amount: Int,
                         orderId: String,
                         customerKey: String,
                         email: String,
                         transactionCallback: @escaping (Float) -> Void) {
        guard let view = view,
              let sdk = tinkoffSDK else { return }
        let pennyAmount = Int64(amount * 100)
        let formattedAmount = format(amount: amount)
        // paymentData
        let data = PaymentInitData(amount: pennyAmount,
                                   orderId: orderId,
                                   customerKey: customerKey,
                                   redirectDueDate: nil,
                                   payType: .oneStage)
        // stageConfig
        let stageConfig = AcquiringPaymentStageConfiguration(paymentStage: .`init`(paymentData: data))
        
        switch method {
            // PAY BY CARD
        case .card:
            // viewConfig
            let viewConfig = AcquiringViewConfiguration()
            viewConfig.featuresOptions.fpsEnabled = false
            viewConfig.featuresOptions.tinkoffPayEnabled = true
            viewConfig.popupStyle = .bottomSheet
            let amountField = AcquiringViewConfiguration.InfoFields.amount(
                title: NSAttributedString(string: "Оплата",
                                          attributes: [.font : UIFont.systemFont(ofSize: 20, weight: .bold)]),
                amount: NSAttributedString(string: "на сумму \(formattedAmount)\u{2006}₽")
            )
            let orderIDField = AcquiringViewConfiguration.InfoFields.detail(
                title: NSAttributedString(string: "Номер заказа \n\(orderId)",
                                          attributes: [
                                            .font : UIFont.systemFont(ofSize: 16, weight: .regular),
                                            .foregroundColor : UIColor.label.withAlphaComponent(0.7)
                                          ])
            )
            let emailField = AcquiringViewConfiguration.InfoFields.email(
                value: email,
                placeholder: "Отправить квитанцию по адресу")
            viewConfig.fields = [amountField, orderIDField, emailField]
            // present VC
            sdk.presentPaymentView(on: view,
                                   customerKey: customerKey,
                                   acquiringPaymentStageConfiguration: stageConfig,
                                   configuration: viewConfig,
                                   tinkoffPayDelegate: nil) { result in
                switch result {
                case let .success(paymentResponse):
                    print("paymentResponse == \(paymentResponse)")
                    if paymentResponse.success {
                        transactionCallback(Float(truncating: paymentResponse.amount))
                    }
                case let .failure(error):
                    print("eRRor == \(error)")
                    break
                }
            }
            // PAY BY SBP
        case .sbp:
            // viewConfig
            let viewConfig = AcquiringViewConfiguration()
            viewConfig.featuresOptions.fpsEnabled = true
            viewConfig.featuresOptions.tinkoffPayEnabled = false
            viewConfig.popupStyle = .bottomSheet
            let amountField = AcquiringViewConfiguration.InfoFields.amount(
                title: NSAttributedString(string: "Оплата",
                                          attributes: [.font : UIFont.systemFont(ofSize: 20, weight: .bold)]),
                amount: NSAttributedString(string: "на сумму \(formattedAmount)\u{2006}₽")
            )
            let orderIDField = AcquiringViewConfiguration.InfoFields.detail(
                title: NSAttributedString(string: "Номер заказа \n\(orderId)",
                                          attributes: [
                                            .font : UIFont.systemFont(ofSize: 16, weight: .regular),
                                            .foregroundColor : UIColor.label.withAlphaComponent(0.7)
                                          ])
            )
            let emailField = AcquiringViewConfiguration.InfoFields.email(
                value: email,
                placeholder: "Отправить квитанцию по адресу")
            viewConfig.fields = [amountField, orderIDField, emailField]
            // acquiringConfig
            let acquiringConfig = AcquiringConfiguration(paymentStage: .none)
            // present VC
            sdk.presentPaymentSbpUrl(on: view,
                                     paymentData: data,
                                     configuration: viewConfig,
                                     acquiringConfiguration: acquiringConfig) { result in
            }
        case .none:
            break
        }
    }
    
}
