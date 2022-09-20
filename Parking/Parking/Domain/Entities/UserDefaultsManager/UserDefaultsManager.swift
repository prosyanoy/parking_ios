//
//  UserDefaultsManager.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 14.09.2022.
//

import Foundation

final class UserDefaultsDataManager {
    private enum Keys: String {
        case userIsRegistered = "userIsRegistered"
        case userIsLogedIn = "userIsLogedIn"
        case userPhoneNumber = "userPhoneNumber"

    }

    static var userIsRegistered: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.userIsRegistered.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.userIsRegistered.rawValue)
        }
    }

    static var userIsLogedIn: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.userIsLogedIn.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.userIsLogedIn.rawValue)
        }
    }
    
    static var userPhoneNumber: String {
        get {
            UserDefaults.standard.string(forKey: Keys.userPhoneNumber.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.userPhoneNumber.rawValue)
        }
    }
}
