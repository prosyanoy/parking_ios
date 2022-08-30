//
//  WalletPaymentSceneConfigurator.swift
//  Parking
//
//  Created by Maxim Terpugov on 16.08.2022.
//

import UIKit


final class WalletPaymentSceneConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure() -> UIViewController {
        let navigationContainer = UINavigationController()
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.shadowColor = .gray
        navigationBarAppearance.backgroundColor = #colorLiteral(red: 0.9728776813, green: 0.9728776813, blue: 0.9728776813, alpha: 1)
        navigationBarAppearance.titleTextAttributes = [.foregroundColor : UIColor.black]
        navigationContainer.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationContainer.navigationBar.standardAppearance = navigationBarAppearance
        
        let router = WalletPaymentRouter(navigationContainer: navigationContainer)
        let repository = PaymentMethodRepository()
        let paymentProvider = PaymentProvider()
        let viewModel = WalletPaymentViewModel(router: router,
                                               paymentMethodRepository: repository,
                                               paymentProvider: paymentProvider)
        let paymentVC = WalletPaymentViewController(viewModel: viewModel)
        paymentProvider.setupDependencies(view: paymentVC)
        navigationContainer.viewControllers = [paymentVC]
        return navigationContainer
    }
}
