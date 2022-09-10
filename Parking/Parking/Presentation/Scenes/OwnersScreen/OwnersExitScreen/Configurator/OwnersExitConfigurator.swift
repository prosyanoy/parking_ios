//
//  OwnersExitConfigurator.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 27.08.2022.
//

import Foundation
import UIKit

final class OwnersExitConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure() -> UIViewController {
        let viewModel = OwnersExitViewModel()
        let vc = OwnersExitViewController(viewModel: viewModel)
        return vc
    }
}
