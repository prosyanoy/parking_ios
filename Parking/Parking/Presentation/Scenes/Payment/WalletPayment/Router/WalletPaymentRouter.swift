//
//  WalletPaymentRouter.swift
//  Parking
//
//  Created by Maxim Terpugov on 23.08.2022.
//

import UIKit


protocol WalletPaymentRouterProtocol {
    func paymentMethodViewTapped(paymentMethods: [PaymentMethod],
                                 selectedMethodCallback: @escaping (PaymentMethod) -> Void)
    func payButtonTapped()
}


final class WalletPaymentRouter: WalletPaymentRouterProtocol {
    
    // MARK: - Dependencies
    
    private weak var navigationContainer: UINavigationController?
    
    
    // MARK: - Init
    
    init(navigationContainer: UINavigationController) {
        self.navigationContainer = navigationContainer
    }
    
    
    // MARK: - PaymentRouterProtocol
    
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
    
    func payButtonTapped() {
        guard let navigationContainer = navigationContainer else { return }
        navigationContainer.presentingViewController?.dismiss(animated: true,
                                                              completion: nil)
    }
    
}
