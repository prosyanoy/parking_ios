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
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let authVC = PhoneNumberConfirmationConfigurator.configure()
        authVC.modalPresentationStyle = .fullScreen
        let rootVC = MainMapConfigurator.configure()
        
        window = UIWindow(windowScene: scene)
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        window?.rootViewController = rootVC
        rootVC.present(authVC, animated: false)
    }
}

