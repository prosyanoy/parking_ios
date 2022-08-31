//
//  WalletPaymentViewModel.swift
//  Parking
//
//  Created by Maxim Terpugov on 23.08.2022.
//

import MommysEye
import Foundation


protocol WalletPaymentViewModelProtocol {
    var selectedPaymentMethod: Publisher<PaymentMethod> { get }
    var isLoading: Publisher<Bool> { get }
    var minimumPaymentAmount: Int { get }
    func viewDidLoad()
    func newPaymentAmountSelected(_ amount: Int)
    func paymentMethodViewTapped()
    func payButtonTapped()
}


final class WalletPaymentViewModel: WalletPaymentViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let router: WalletPaymentRouterProtocol
    private let paymentMethodRepository: PaymentMethodGateway
    private let paymentProvider: PaymentProviderProtocol
    
    
    // MARK: - Init
    
    init(router: WalletPaymentRouterProtocol,
         paymentMethodRepository: PaymentMethodGateway,
         paymentProvider: PaymentProviderProtocol) {
        self.router = router
        self.paymentMethodRepository = paymentMethodRepository
        self.paymentProvider = paymentProvider
    }
    
    
    // MARK: - State
    
    var selectedPaymentMethod = Publisher(
        value: PaymentMethod(title: "",
                             description: "",
                             icon: nil,
                             signature: .none)
    )
    var isLoading = Publisher(value: false)
    var minimumPaymentAmount: Int = 50
    
    
    // MARK: - Private State
    
    private var paymentMethods = [PaymentMethod]()
    private lazy var selectedPaymentAmount = minimumPaymentAmount
    
    
    // MARK: - PaymentViewModelProtocol
    
    func viewDidLoad() {
        isLoading.value = true
        let _ = Task {
            do {
                let result = try await paymentMethodRepository.fetch()
                guard !result.isEmpty else { return }
                self.selectedPaymentMethod.value = result[0]
                self.paymentMethods = result
            } catch {
                
            }
            self.isLoading.value = false
        }
    }
    
    func newPaymentAmountSelected(_ amount: Int) {
        selectedPaymentAmount = amount
    }
    
    func paymentMethodViewTapped() {
        router.paymentMethodViewTapped(paymentMethods: paymentMethods,
                                       selectedMethodCallback: { [weak self] selectedPaymentMethod in
            self?.selectedPaymentMethod.value = selectedPaymentMethod
        })
    }
    
    func payButtonTapped() {
        let userData = user.value
        let orderID = String(Int.random(in: 100000..<99999999))
        paymentProvider.payButtonTapped(method: selectedPaymentMethod.value.signature,
                                        amount: selectedPaymentAmount,
                                        orderId: orderID,
                                        customerKey: userData.id.uuidString,
                                        email: userData.email,
                                        transactionCallback: { paidAmoint in
            // TODO: Менять поле баланс кошелька только через бек
            user.value.walletBalance += paidAmoint
        })
    }
    
}
