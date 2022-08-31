//
//  MapFiltersRouter.swift
//  Parking
//
//  Created by Maxim Terpugov on 30.08.2022.
//

import UIKit


protocol MapFiltersRouterProtocol {
    func applyButtonTapped()
}


final class MapFiltersRouter: MapFiltersRouterProtocol {
    
    // MARK: - Dependencies

    private weak var navigationContainer: UINavigationController?
    
    
    // MARK: - Init

    init(navigationContainer: UINavigationController) {
        self.navigationContainer = navigationContainer
    }
    
    
    // MARK: - MapFiltersRouterProtocol
    
    func applyButtonTapped() {
        navigationContainer?.dismiss(animated: true, completion: nil)
    }
    
}
