//
//  NewCarConfigurator.swift
//  Parking
//
//  Created by mac on 11.09.2022.
//


import Foundation
import UIKit

final class NewCarConfigurator: SceneConfiguratorProtocol_CN {

    static func configure() -> UIViewController {
        let viewModel = NewCarViewModel()
        let newCarVC = NewCarNumberViewController(viewModel: viewModel)
        return newCarVC
    }
}
