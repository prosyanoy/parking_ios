//
//  MenuNavigationController.swift
//  Parking
//
//  Created by Sofia Lupeko on 07.08.2022.
//

import UIKit

final class MenuNavigationController: UINavigationController {

	override func viewDidLoad() {
		configureUI()
	}

	private func configureUI() {
        navigationBar.tintColor = UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1)
	}
}
