//
//  ParkingSearchBottomSheetRouter.swift
//  Parking
//
//  Created by Maxim Terpugov on 19.08.2022.
//

import UIKit


protocol ParkingSearchBottomSheetRouterProtocol {
    func parkingSearchButtonTapped(callback: @escaping () -> Void)
}


final class ParkingSearchBottomSheetRouter: ParkingSearchBottomSheetRouterProtocol {
    
    // MARK: - Dependencies

    private weak var view: UIViewController?
    
    
    // MARK: - Init

    func setupDependencies(view: UIViewController) {
        self.view = view
    }
    
    
    // MARK: - ParkingSearchBottomSheetRouterProtocol

    func parkingSearchButtonTapped(callback: @escaping () -> Void) {
        view?.dismiss(animated: true, completion: {
            callback()
        })
    }
    
}
