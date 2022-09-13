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
        case notify10MinutesBeforeBooking = "notify10MinutesBeforeBooking"
        case notifyBookingStarts = "notifyBookingStarts"
        case notify10minutesEndingBooking = "notify10minutesEndingBooking"
        case notifyAtTheEndOfParking = "notifyAtTheEndOfParking"
        case notifyAwayFromTheParking = "notifyAwayFromTheParking"
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
    
    static var notify10MinutesBeforeBooking: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.notify10MinutesBeforeBooking.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.notify10MinutesBeforeBooking.rawValue)
        }
    }
    
    static var notifyBookingStarts: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.notifyBookingStarts.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.notifyBookingStarts.rawValue)
        }
    }
    
    static var notify10minutesEndingBooking: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.notify10minutesEndingBooking.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.notify10minutesEndingBooking.rawValue)
        }
    }
    
    static var notifyAtTheEndOfParking: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.notifyAtTheEndOfParking.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.notifyAtTheEndOfParking.rawValue)
        }
    }
    
    static var notifyAwayFromTheParking: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.notifyAwayFromTheParking.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.notifyAwayFromTheParking.rawValue)
        }
    }
}
