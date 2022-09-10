//
//  CodeEnterPageConfiguration.swift
//  Parking
//
//  Created by Анатолий Силиверстов and Denis Zagudaev on 11.09.2022.
//


import Foundation
import UIKit

final class CodeEnterPageConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configureWith(phoneNumber: String) -> UIViewController {
        let viewModel = CodeEnterPageViewModel(inputNumber: phoneNumber, confirmationSmsCode: "")
        let vc = CodeEnterPageViewController(viewModel: viewModel, nibName: nil, bundle: nil)
        return vc
    }
}
