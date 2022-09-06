//
//  PaymentChoiceSceneConfigurator.swift
//  Parking
//
//  Created by Maxim Terpugov on 24.08.2022.
//

import UIKit


final class PaymentChoiceSceneConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure(
        navigationContainer: UINavigationController,
        paymentMethods: [PaymentMethod],
        selectedPaymentMethodCallback: @escaping (PaymentMethod) -> Void
    ) -> UIViewController {
        let router = PaymentChoiceRouter(navigationContainer: navigationContainer)
        let paymentProvider = PaymentProvider()
        let viewModel = PaymentChoiceViewModel(paymentMethods: paymentMethods,
                                               paymentProvider: paymentProvider,
                                               router: router,
                                               selectedPaymentMethodCallback: selectedPaymentMethodCallback)
        let paymentChoiceVC = PaymentChoiceViewController(viewModel: viewModel)
        paymentProvider.setupDependencies(view: paymentChoiceVC)
        return paymentChoiceVC
    }
    
}
