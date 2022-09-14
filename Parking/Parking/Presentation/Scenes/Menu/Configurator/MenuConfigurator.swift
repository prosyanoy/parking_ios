//
//  MenuConfigurator.swift
//  Parking
//
//  Created by Sofia Lupeko on 06.08.2022.
//

import Foundation
import UIKit

final class MenuConfigurator: SceneConfiguratorProtocol_CN {

	static func configure() -> UIViewController {

        let router = MenuRouter()
		let viewModel = MenuViewModel(router: router)
		let menuTableView = MenuTableView()
		let menuVC = MenuViewController(viewModel: viewModel, menuTableView: menuTableView)
		let menuNC = MenuNavigationController(rootViewController: menuVC)

		return menuNC
	}
}
