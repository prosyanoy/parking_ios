//
//  OwnersPhoneNumberCOnfirmationConfigurator.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 01.09.2022.
//

import Foundation
import UIKit

final class OwnersPhoneNumberCOnfirmationConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure() -> UIViewController {
        let viewModel = OwnersPhoneNumberConfirmationViewModel()
        let vc = OwnersPhoneNumberConfirmationViewController(viewModel: viewModel,
                                                       nibName: nil,
                                                       bundle: nil)
        return vc
    }
}
