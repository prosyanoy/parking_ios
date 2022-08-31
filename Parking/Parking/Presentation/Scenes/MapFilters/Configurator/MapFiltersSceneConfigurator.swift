//
//  MapFiltersSceneConfigurator.swift
//  Parking
//
//  Created by Maxim Terpugov on 30.08.2022.
//

import UIKit


final class MapFiltersSceneConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure(applyFiltersCallback: @escaping (FilterParameters) -> Void) -> UIViewController {
        let navigationContainer = UINavigationController()

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.shadowColor = .gray
        navigationBarAppearance.backgroundColor = #colorLiteral(red: 0.9728776813, green: 0.9728776813, blue: 0.9728776813, alpha: 1)
        navigationBarAppearance.titleTextAttributes = [.foregroundColor : UIColor.black]
        navigationContainer.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationContainer.navigationBar.standardAppearance = navigationBarAppearance
        
        let router = MapFiltersRouter(navigationContainer: navigationContainer)
        let viewModel = MapFiltersViewModel(router: router,
                                            applyFiltersCallback: applyFiltersCallback)
        let mapFiltersVC = MapFiltersViewController(viewModel: viewModel)
        navigationContainer.viewControllers = [mapFiltersVC]
        return navigationContainer
    }
    
}
