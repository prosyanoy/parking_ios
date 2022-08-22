//
//  MainMapConfigurator.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.07.2022.
//

import BabyNet
import UIKit
import YandexMapsMobile


final class MainMapConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure() -> UIViewController {
        let networkClient = BabyNetRepository()
        let parkingNetworkRepo = ParkingNetworkRepository(client: networkClient)
        let parkingRepository = ParkingRepository(network: parkingNetworkRepo)
        let navigationContainer = UINavigationController()
        navigationContainer.navigationBar.isHidden = true
        let router = MainMapRouter(navigationContainer: navigationContainer)
        let viewModel = MainMapViewModel(parkingRepository: parkingRepository,
                                         router: router)
        let fullScreenBounds = UIScreen.main.bounds
        let yMapView = YMKMapView(frame: fullScreenBounds,
                                  vulkanPreferred: true) ?? YMKMapView()
        let yMapDrawer = MainMapYMKDrawer(mapView: yMapView,
                                          interactor: viewModel)
        let mapButtonsLayer = MapButtonsView(targetDelegate: yMapDrawer)
        let mapVC = MainMapViewController(viewModel: viewModel,
                                          yMapDrawer: yMapDrawer,
                                          yMapView: yMapView,
                                          mapButtonsView: mapButtonsLayer,
                                          nibName: nil,
                                          bundle: nil)
        navigationContainer.viewControllers = [mapVC]
        return navigationContainer
    }
}
