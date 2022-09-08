//
//  AboutConfigurator.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 19.08.2022.
//

import UIKit

final class AboutConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure() -> UIViewController {
        let viewModel = AboutViewModel()
        let aboutVC = AboutViewController(viewModel: viewModel,
                                          nibName: nil,
                                          bundle: nil)
        return aboutVC
    }
}
