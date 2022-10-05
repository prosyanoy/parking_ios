//
//  ChangePhonenumberConfigurator.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 01.10.2022.
//

import Foundation
import UIKit

final class ChangePhonenumberConfigurator: SceneConfiguratorProtocol_CN {
    static func configure() -> UIViewController {
        let viewModel = ChangePhonenumberViewModel()
        let changePhonenumberVC = ChangePhonenumberViewController(viewModel: viewModel)
        return changePhonenumberVC
    }
}
