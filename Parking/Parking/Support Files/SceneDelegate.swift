//
//  SceneDelegate.swift
//  Parking
//
//  Created by Sofia Lupeko on 23.07.2022.
//

import UIKit
import YandexMapsMobile

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let userAuthVC = UserPhoneNumberConfirmationConfigurator.configure()
        let mainMapVC = MainMapConfigurator.configure()
        let rootVC = ContentViewController()
        
        window = UIWindow(windowScene: scene)
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        window?.rootViewController = rootVC
        rootVC.addAndPresent(mainMapVC, presentedController: userAuthVC)
    }
}
