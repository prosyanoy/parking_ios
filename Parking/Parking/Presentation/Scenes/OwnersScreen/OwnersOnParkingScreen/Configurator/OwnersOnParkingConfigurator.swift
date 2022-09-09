//
//  OwnersOnParkingConfigurator.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 28.08.2022.
//

import Foundation
import UIKit

final class OwnersOnParkingConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure() -> UIViewController {
        let viewModel = OwnersOnParkingViewModel()
        let vc = OwnersOnParkingViewController(viewModel: viewModel)
        return vc
    }
}
