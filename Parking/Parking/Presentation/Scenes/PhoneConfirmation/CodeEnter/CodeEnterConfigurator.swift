//
//  CodeEnterConfigurator.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 26.08.2022.
//

import Foundation
import UIKit

final class CodeEnterConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configureWith(phoneNumber: String, confirmationCode: String) -> UIViewController {
        let viewModel = CodeEnterViewModel(confirmationCode: confirmationCode, inputNumber: phoneNumber)
        let vc = CodeEnterViewController(phoneNumber: viewModel.inputNumber, confirmationCode: viewModel.confirmationCode, viewModel: viewModel, nibName: nil, bundle: nil)
        return vc
    }
}
