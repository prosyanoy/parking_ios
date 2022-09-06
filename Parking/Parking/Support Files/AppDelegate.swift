//
//  AppDelegate.swift
//  Parking
//
//  Created by Sofia Lupeko on 23.07.2022.
//

import UIKit
import YandexMapsMobile
import UserNotifications
import MommysEye
//import CoreLocation

// Пока что меняю поля из юая, в дальнейшем юзер онли гет, менять поля только через бэк
var user = Publisher(value: User(id: UUID(uuidString: "1444fbdb-2d28-48be-86bf-141553a2719f")!,
                                 email: "4440449@gmail.com",
                                 walletBalance: 11,
                                 licencePlate: "А 777 АА 777"))

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var orientationLock = UIInterfaceOrientationMask.portrait
    
	private func setupMapKit() {
		guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist") else { return }
		guard let keys = NSDictionary(contentsOfFile: path) else { return }
		guard let mapKitApiKey = keys["MapKitAPIKey"] as? String else { return }
		YMKMapKit.setApiKey(mapKitApiKey)
		YMKMapKit.sharedInstance()
	}

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		setupMapKit()
        // Для отображения приложения в настройках девайса
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isAllowed, error in }
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
    }

}

