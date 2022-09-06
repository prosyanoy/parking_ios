//
//  ParkingPaymentViewModel.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.08.2022.
//

import MommysEye


protocol ParkingPaymentViewModelProtocol {
    var paidParking: Publisher<Parking> { get }
    var selectedPaymentMethod: Publisher<PaymentMethod> { get }
    var isLoading: Publisher<Bool> { get }
    func viewDidLoad()
    func paymentMethodViewTapped()
    func payButtonTapped()
    func cancelButtonTapped()
}


final class ParkingPaymentViewModel: ParkingPaymentViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let router: ParkingPaymentRouterProtocol
    private let paymentMethodRepository: PaymentMethodGateway
    private let paymentProvider: PaymentProviderProtocol
    
    
    // MARK: - Init
    
    init(router: ParkingPaymentRouterProtocol,
         paymentMethodRepository: PaymentMethodGateway,
         paymentProvider: PaymentProviderProtocol,
         paidParking: Parking) {
        self.router = router
        self.paymentMethodRepository = paymentMethodRepository
        self.paymentProvider = paymentProvider
        self.paidParking = Publisher(value: paidParking)
    }
    
    
    // MARK: - State
    
    var paidParking: Publisher<Parking>
    var selectedPaymentMethod = Publisher(
        value: PaymentMethod(title: "",
                             description: "",
                             icon: nil,
                             signature: .none)
    )
    var isLoading = Publisher(value: false)
    
    
    // MARK: - Private State
    
    private var paymentMethods = [PaymentMethod]()
    
    
    // MARK: - ParkingPaymentViewModelProtocol
    
    func viewDidLoad() {
        paidParking.notify()
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
    
    func paymentMethodViewTapped() {
        router.paymentMethodViewTapped(paymentMethods: paymentMethods,
                                       selectedMethodCallback: { [weak self] selectedPaymentMethod in
            self?.selectedPaymentMethod.value = selectedPaymentMethod
        })
    }
    
    func payButtonTapped() {
        let userData = user.value
        // TODO: orserID - получение с бека?
        let orderID = String(Int.random(in: 100000..<99999999))
        paymentProvider.payButtonTapped(
            method: selectedPaymentMethod.value.signature,
            amount:Int(paidParking.value.hourCost),
            orderId: orderID,
            customerKey: userData.id.uuidString,
            email: userData.email,
            transactionCallback: { paidAmount in
                // TODO: Менять поле баланс кошелька только через бек
                user.value.walletBalance += paidAmount
            }
        )
    }
    
    func cancelButtonTapped() {
        router.cancelButtonTapped()
    }
    
}
