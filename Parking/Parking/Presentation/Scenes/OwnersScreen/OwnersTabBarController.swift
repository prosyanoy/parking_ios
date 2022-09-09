//
//  OwnersTabBarController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 26.08.2022.
//

import Foundation
import UIKit

final class OwnersTabBarController: UITabBarController {
        
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUpNavigation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNavigation() {
        tabBar.tintColor = .darkGray
        tabBar.barTintColor = .lightGray
        tabBar.backgroundColor = .white
        
        tabBar.layer.borderColor = UIColor.darkGray.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let ownersOnParkingViewController = OwnersOnParkingConfigurator.configure()
        let ownersEntryViewController = OwnersEntryConfigurator.configure()
        let ownersExitViewController = OwnersExitConfigurator.configure()
        
        let onParkingNavigation = OwnersNavigationController(rootViewController: ownersOnParkingViewController)
        let entryNavigation = OwnersNavigationController(rootViewController: ownersEntryViewController)
        let exitNavigation = OwnersNavigationController(rootViewController: ownersExitViewController)
        
        entryNavigation.tabBarItem = UITabBarItem(title: "Въезд",
                                                  image: UIImage(named: "Download"),
                                                  tag: 0)
        onParkingNavigation.tabBarItem = UITabBarItem(title: "На стоянке",
                                                      image: UIImage(named: "HardDrive"),
                                                      tag: 1)
        exitNavigation.tabBarItem = UITabBarItem(title: "Выезд",
                                                 image: UIImage(named: "Upload"),
                                                 tag: 2)
        
        setViewControllers([
            entryNavigation,
            onParkingNavigation,
            exitNavigation
        ], animated: false)
    }
}
