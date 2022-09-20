//
//  CityAndPhoneConfigurator.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 11.09.2022.
//

import Foundation
import UIKit

final class CityAndPhoneConfigurator: SceneConfiguratorProtocol_CN {
    
    static func configure() -> UIViewController {
        let vc = CityAndPhonePageViewController()
        return vc
    }
}
