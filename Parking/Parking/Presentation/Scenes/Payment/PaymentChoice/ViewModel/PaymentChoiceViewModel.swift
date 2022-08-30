//
//  PaymentChoiceViewModel.swift
//  Parking
//
//  Created by Maxim Terpugov on 24.08.2022.
//


protocol PaymentChoiceViewModelProtocol {
    var paymentMethods: [PaymentMethod] { get }
    func didSelectRow(index: Int)
    func addCardButtonTapped()
}


final class PaymentChoiceViewModel: PaymentChoiceViewModelProtocol {
    
    
    // MARK: - Dependencies
    
    private let router: PaymentChoiceRouterProtocol
    private let paymentProvider: PaymentChoiceProviderProtocol
    private let selectedPaymentMethodCallback: (PaymentMethod) -> Void
    
    
    // MARK: - Init
    
    init(paymentMethods: [PaymentMethod],
         paymentProvider: PaymentChoiceProviderProtocol,
         router: PaymentChoiceRouterProtocol,
         selectedPaymentMethodCallback: @escaping (PaymentMethod) -> Void) {
        self.paymentMethods = paymentMethods
        self.paymentProvider = paymentProvider
        self.router = router
        self.selectedPaymentMethodCallback = selectedPaymentMethodCallback
    }
    
    
    // MARK: - State
    
    private (set) var paymentMethods: [PaymentMethod]
    
    
    // MARK: - PaymentChoiceViewModelProtocol
    
    func didSelectRow(index: Int) {
        let method = paymentMethods[index]
        selectedPaymentMethodCallback(method)
        router.didSelectRow()
    }
    
    func addCardButtonTapped() {
        paymentProvider.addCardButtonTapped(customerKey: user.value.id.uuidString)
    }
    
}
