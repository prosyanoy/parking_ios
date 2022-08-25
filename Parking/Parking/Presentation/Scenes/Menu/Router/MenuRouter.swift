//
//  MenuRouter.swift
//  Parking
//
//  Created by Sofia Lupeko on 01.08.2022.
//

import Foundation

protocol MenuRouterProtocol {
	func menuCellTapped(with model: MenuCell)
}

final class MenuRouter: MenuRouterProtocol {
	func menuCellTapped(with model: MenuCell) {
		print(model.title)
	}
}


