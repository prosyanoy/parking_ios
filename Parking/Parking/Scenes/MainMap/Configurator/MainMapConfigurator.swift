//
//  MainMapConfigurator.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.07.2022.
//

import BabyNet
import UIKit


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
        let mapVC = MainMapViewController(viewModel: viewModel,
                                          nibName: nil,
                                          bundle: nil)
        navigationContainer.viewControllers = [mapVC]
        return navigationContainer
    }
}
