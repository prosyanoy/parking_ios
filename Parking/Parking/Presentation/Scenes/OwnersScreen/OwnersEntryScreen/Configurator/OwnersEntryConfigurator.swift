//
//  OwnersEntryConfigurator.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 28.08.2022.
//

import Foundation
import UIKit

final class OwnersEntryConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure() -> UIViewController {
        let viewModel = OwnersEntryViewModel()
        let vc = OwnersEntryViewController(viewModel: viewModel)
        return vc
    }
}
