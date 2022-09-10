//
//  MenuRegistration.swift
//  Parking
//
//  Created by Denis Zagudaev on 21.08.2022.
//

import UIKit

final class OnboardingConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure() -> UIViewController {
        let viewModel = OboardingPageViewModel()
        let pageVC = PageViewController()
        let vc = OnboadrdingViewController(viewModel: viewModel, pageVC: pageVC, nibName: nil, bundle: nil)
        
        return vc
    }
    
  
}
