//
//  ParkingPaymentSceneConfigurator.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.08.2022.
//

import UIKit



final class ParkingPaymentSceneConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure(paidParking: Parking) -> UIViewController {
        let navigationContainer = UINavigationController()
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.shadowColor = .gray
        navigationBarAppearance.backgroundColor = #colorLiteral(red: 0.9728776813, green: 0.9728776813, blue: 0.9728776813, alpha: 1)
        navigationBarAppearance.titleTextAttributes = [.foregroundColor : UIColor.black]
        navigationContainer.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationContainer.navigationBar.standardAppearance = navigationBarAppearance
        
        let router = ParkingPaymentRouter(navigationContainer: navigationContainer)
        let repository = PaymentMethodRepository()
        let paymentProvider = PaymentProvider()
        let viewModel = ParkingPaymentViewModel(
            router: router,
            paymentMethodRepository: repository,
            paymentProvider: paymentProvider,
            paidParking: paidParking)
        let parkingPaymentVC = ParkingPaymentViewController(viewModel: viewModel)
        paymentProvider.setupDependencies(view: parkingPaymentVC)
        navigationContainer.viewControllers = [parkingPaymentVC]
        
        return navigationContainer
    }
    
}
