//
//  SettingsConfigurator.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 17.08.2022.
//

import UIKit

final class SettingsConfigurator: SceneConfiguratorProtocol_CN {

    static func configure() -> UIViewController {
        let viewModel = SettingsViewModel()
        let settingsTableView = SettingsTableView()
        let settingsVC = SettingsViewController(viewModel: viewModel, settingsTableView: settingsTableView)
        return settingsVC
    }
}
