//
//  SearchSceneConfigurator.swift
//  Parking
//
//  Created by Maxim Terpugov on 17.08.2022.
//

import UIKit


final class SearchSceneConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure(parkings: [Parking], selectedParkingCallback: @escaping (Parking) -> Void) -> UIViewController {
        let viewModel = SearchViewModel(parkings: parkings,
                                        selectedParkingCallback: selectedParkingCallback)
        let searchVC = SearchViewController(viewModel: viewModel)
        let navigationContainer = UINavigationController(rootViewController: searchVC)
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
