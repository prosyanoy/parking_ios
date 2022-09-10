//
//  OwnersNavigationController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 26.08.2022.
//

import Foundation
import UIKit

final class OwnersNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 17)
        ]
    }
}
