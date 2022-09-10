//
//  PhoneNumberConfirmationConfigurator.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 23.08.2022.
//

import Foundation
import UIKit

final class UserPhoneNumberConfirmationConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure() -> UIViewController {
        let viewModel = UserPhoneNumberConfirmationViewModel()
        let vc = UserPhoneNumberConfirmationViewController(viewModel: viewModel,
                                                       nibName: nil,
                                                       bundle: nil)
        return vc
    }
}
