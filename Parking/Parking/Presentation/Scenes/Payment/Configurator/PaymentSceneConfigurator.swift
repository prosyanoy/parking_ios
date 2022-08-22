//
//  PaymentSceneConfigurator.swift
//  Parking
//
//  Created by Maxim Terpugov on 16.08.2022.
//

import UIKit


final class PaymentSceneConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure() -> UIViewController {
        let paymentVC = PaymentViewController()
        let navigationContainer = UINavigationController(rootViewController: paymentVC)
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.shadowColor = .gray
        navigationBarAppearance.backgroundColor = #colorLiteral(red: 0.9728776813, green: 0.9728776813, blue: 0.9728776813, alpha: 1)
        navigationBarAppearance.titleTextAttributes = [.foregroundColor : UIColor.black]
        navigationContainer.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationContainer.navigationBar.standardAppearance = navigationBarAppearance
        return navigationContainer
    }
}
