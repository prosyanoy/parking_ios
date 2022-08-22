//
//  MainMapRouter.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.07.2022.
//

import Foundation
import UIKit


protocol MainMapRouterProtocol {
    func onMapTap()
    func onMapParkingObjectTap(parking: Parking,
                               didLayoutHeightCallback: @escaping (Float) -> Void,
                               dismissOrderSheetCallback: @escaping () -> Void)
    func menuButtonTapped()
    func paymentButtonTapped()
    func searchButtonTapped(parkings: [Parking],
                            selectedParkingCallback: @escaping(Parking) -> Void)
    func searchParkingButtonTapped(parkings: [Parking],
                                   selectedParkingCallback: @escaping(Parking) -> Void,
                                   didLayoutHeightCallback: @escaping (Float) -> Void,
                                   dismissOrderSheetCallback: @escaping () -> Void)
}


final class MainMapRouter: MainMapRouterProtocol {
    
    // MARK: - Dependencies
    
    private unowned var navigationContainer: UINavigationController
    
    
    // MARK: - Init
    
    init(navigationContainer: UINavigationController) {
        self.navigationContainer = navigationContainer
    }
    
    
    // MARK: - Private
    
    private func dismissPresentedVCIfPossible() {
        if let presentedVC = navigationContainer.presentedViewController as? OrderSheetViewController {
            presentedVC.dismiss(animated: true, completion: nil)
        } else if let presentedVC = navigationContainer.presentedViewController as? ParkingSearchBottomSheet {
            presentedVC.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Interface
    
    func onMapTap() {
        dismissPresentedVCIfPossible()
    }
    
    func onMapParkingObjectTap(parking: Parking,
                               didLayoutHeightCallback: @escaping (Float) -> Void,
                               dismissOrderSheetCallback: @escaping () -> Void) {
        dismissPresentedVCIfPossible()
        let transitionDelegate = OrderSheetTransitionDelegate()
        let orderVC = OrderSheetViewController(transitionDelegate: transitionDelegate,
                                               parking: parking,
                                               didLayoutHeightCallback: didLayoutHeightCallback,
                                               dismissOrderSheetCallback: dismissOrderSheetCallback,
                                               nibName: nil,
                                               bundle: nil)
        orderVC.modalPresentationStyle = .custom
        orderVC.transitioningDelegate = transitionDelegate
        navigationContainer.present(orderVC,
                                    animated: true,
                                    completion: nil)
    }
    
    func menuButtonTapped() {
        dismissPresentedVCIfPossible()
        let menuVC = MenuConfigurator.configure()
        navigationContainer.present(menuVC,
                                    animated: true,
                                    completion: nil)
    }
    
    func paymentButtonTapped() {
        dismissPresentedVCIfPossible()
        let paymentVC = PaymentSceneConfigurator.configure()
        navigationContainer.present(paymentVC,
                                    animated: true,
                                    completion: nil)
    }
    
    func searchButtonTapped(parkings: [Parking],
                            selectedParkingCallback: @escaping(Parking) -> Void) {
        dismissPresentedVCIfPossible()
        let searchVC = SearchSceneConfigurator.configure(
            parkings: parkings,
            selectedParkingCallback: selectedParkingCallback)
        navigationContainer.present(searchVC,
                                    animated: true,
                                    completion: nil)
    }
    
    func searchParkingButtonTapped(parkings: [Parking],
                                   selectedParkingCallback: @escaping(Parking) -> Void,
                                   didLayoutHeightCallback: @escaping (Float) -> Void,
                                   dismissOrderSheetCallback: @escaping () -> Void) {
        // Прокидываю зависимости для следующего экрана
        let searchParkingBottomSheetVC = ParkingSearchBottomSheetSceneConfigurator.configure(
            searchButtonTappedCallback: { [weak self] in
                let searchVC = SearchSceneConfigurator.configure(
                    parkings: parkings,
                    selectedParkingCallback: selectedParkingCallback
                )
                self?.navigationContainer.present(searchVC,
                                                  animated: true,
                                                  completion: nil)
            },
            didLayoutHeightCallback: didLayoutHeightCallback,
            dismissOrderSheetCallback: dismissOrderSheetCallback
        )
        navigationContainer.present(searchParkingBottomSheetVC,
                                    animated: true,
                                    completion: nil)
    }
    
}
