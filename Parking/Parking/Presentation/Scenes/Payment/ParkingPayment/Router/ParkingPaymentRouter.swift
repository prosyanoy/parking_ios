//
//  ParkingPaymentRouter.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.08.2022.
//

import UIKit


protocol ParkingPaymentRouterProtocol {
    func paymentMethodViewTapped(paymentMethods: [PaymentMethod],
                                 selectedMethodCallback: @escaping (PaymentMethod) -> Void)
    func cancelButtonTapped()
}


final class ParkingPaymentRouter: ParkingPaymentRouterProtocol {
    
    // MARK: - Dependencies
    
    private weak var navigationContainer: UINavigationController?

    
    // MARK: - Init
    
    init(navigationContainer: UINavigationController) {
        self.navigationContainer = navigationContainer
    }
    
    // MARK: - ParkingPaymentRouterProtocol

    func paymentMethodViewTapped(paymentMethods: [PaymentMethod],
                                 selectedMethodCallback: @escaping (PaymentMethod) -> Void) {
        guard let navigationContainer = navigationContainer else { return }
        
        let paymentChoiceVC = PaymentChoiceSceneConfigurator.configure(
            navigationContainer: navigationContainer,
            paymentMethods: paymentMethods,
            selectedPaymentMethodCallback: selectedMethodCallback
        )
        navigationContainer.pushViewController(paymentChoiceVC,
                                               animated: true)
    }
    
    func cancelButtonTapped() {
        navigationContainer?.dismiss(animated: true,
                                     completion: nil)
    }
}
