//
//  ProfileConfigurator.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 06.09.2022.
//

import Foundation
import UIKit

final class ProfileConfigurator: SceneConfiguratorProtocol_CN {
    static func configure() -> UIViewController {
        let viewModel = ProfileViewModel()
        let profileVC = ProfileViewController(viewModel: viewModel)
        return profileVC
    }
}
