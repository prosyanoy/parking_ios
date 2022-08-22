//
//  ParkingSearchBottomSheetSceneConfigurator.swift
//  Parking
//
//  Created by Maxim Terpugov on 19.08.2022.
//

import UIKit


final class ParkingSearchBottomSheetSceneConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure(searchButtonTappedCallback: @escaping () -> Void,
                          didLayoutHeightCallback: @escaping (Float) -> Void,
                          dismissOrderSheetCallback: @escaping () -> Void) -> UIViewController {
        let transitionDelegate = ParkingSearchBottomSheetTransitionDelegate()
        let router = ParkingSearchBottomSheetRouter()
        let viewModel = ParkingSearchBottomSheetViewModel(
            router: router,
            searchButtonTappedCallback: searchButtonTappedCallback)
        let parkingSearchVC = ParkingSearchBottomSheet(
            viewModel: viewModel,
            transitionDelegate: transitionDelegate,
                    didLayoutHeightCallback: didLayoutHeightCallback,
                    dismissOrderSheetCallback: dismissOrderSheetCallback)
        parkingSearchVC.modalPresentationStyle = .custom
        parkingSearchVC.transitioningDelegate = transitionDelegate

        router.setupDependencies(view: parkingSearchVC)
        return parkingSearchVC
    }
}
