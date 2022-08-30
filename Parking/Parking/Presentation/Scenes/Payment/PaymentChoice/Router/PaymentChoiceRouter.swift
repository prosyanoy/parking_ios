//
//  PaymentChoiceRouter.swift
//  Parking
//
//  Created by Maxim Terpugov on 24.08.2022.
//

import UIKit


protocol PaymentChoiceRouterProtocol {
    func didSelectRow()
}


final class PaymentChoiceRouter: PaymentChoiceRouterProtocol {
    
    // MARK: - Dependencies

    private weak var navigationContainer: UINavigationController?
    
    
    // MARK: - Init

    init(navigationContainer: UINavigationController) {
        self.navigationContainer = navigationContainer
    }
    
    
    // MARK: - PaymentChoiceRouterProtocol

    func didSelectRow() {
        navigationContainer?.popViewController(animated: true)
    }
    
}
