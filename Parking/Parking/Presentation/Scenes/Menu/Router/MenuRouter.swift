//
//  MenuRouter.swift
//  Parking
//
//  Created by Sofia Lupeko on 01.08.2022.
//

import UIKit

protocol MenuRouterProtocol {
	func menuCellTapped(with model: MenuCell)
}

final class MenuRouter: MenuRouterProtocol {

	func menuCellTapped(with model: MenuCell) {
		print(model.title)
	}
}


