//
//  MainMapRouter.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.07.2022.
//

import Foundation
import UIKit


protocol MainMapRouterProtocol {
    func parkingButtonTapped()
    func onMapTap()
    func onMapParkingObjectTap(parking: Parking,
                             _ dismissOrderSheetCallback: @escaping () -> Void)
}


final class MainMapRouter: MainMapRouterProtocol {
    
    // MARK: - Dependencies

    private unowned var navigationContainer: UINavigationController
    
    
    // MARK: - Init

    init(navigationContainer: UINavigationController) {
        self.navigationContainer = navigationContainer
    }
    
    
    // MARK: - Interface

    func parkingButtonTapped() {
    }
    
    func onMapTap() {
        guard let presentedVC = navigationContainer.presentedViewController as? OrderSheetViewController else { return }
        presentedVC.dismiss(animated: true, completion: nil)
    }
    
    func onMapParkingObjectTap(parking: Parking,
                             _ dismissOrderSheetCallback: @escaping () -> Void) {
        if let presentedVC = navigationContainer.presentedViewController as? OrderSheetViewController {
            presentedVC.dismiss(animated: true, completion: nil)
        }
        let transitionDelegate = OrderSheetTransitionDelegate()
        let orderVC = OrderSheetViewController(transitionDelegate: transitionDelegate,
                                               parking: parking,
                                               dismissOrderSheetCallback: dismissOrderSheetCallback,
                                               nibName: nil,
                                               bundle: nil)
        orderVC.modalPresentationStyle = .custom
        orderVC.transitioningDelegate = transitionDelegate
        navigationContainer.present(orderVC, animated: true,
                                    completion: nil)
    }
}
