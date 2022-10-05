//
//  ConfirmationCodeEnterConfigurator.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 02.10.2022.
//

import Foundation
import UIKit

final class ConfirmationCodeEnterConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configureWith(phoneNumber: String, confirmationCode: String, requestType: RequestType) -> UIViewController {
        let viewModel = ConfirmationCodeEnterViewModel(confirmationCode: confirmationCode, inputNumber: phoneNumber, requestType: requestType)
        let vc = ConfirmationCodeEnterViewController(viewModel: viewModel, nibName: nil, bundle: nil)
        return vc
    }
}
