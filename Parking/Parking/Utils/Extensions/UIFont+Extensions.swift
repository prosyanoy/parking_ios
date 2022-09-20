//
//  UIFont+Extensions.swift
//  Parking
//
//  Created by Lupeko Sofia on 04.09.2022.
//

import UIKit

extension UIFont {
    // если нужно создать свой новый шрифт - используем аналогичную инициализацию
    // меняем размер, название
    // в else пишем шрифт похожий на создаваемый
    // ОБЯЗАТЕЛЬНО ПРОВЕРЯЕМ ЧТО НАЗВАНИЕ НАПИСАНО ПРАВИЛЬНО
    // И ПРИ ВЫЗОВЕ ПРОВАЛИВАЕМСЯ В custom font
    static var overpassMedium16: UIFont {
        if let customFont = UIFont(name: "Overpass-Medium", size: 16) {
            return customFont
        } else {
            return .systemFont(ofSize: 16)
        }
    }
    static var overpassBold16: UIFont {
        if let customFont = UIFont(name: "Overpass-Bold", size: 16) {
            return customFont
        } else {
            return .boldSystemFont(ofSize: 16)
        }
    }
    static var overpassMedium17: UIFont {
        if let customFont = UIFont(name: "Overpass-Medium", size: 17) {
            return customFont
        } else {
            return .systemFont(ofSize: 17)
        }
    }
    static var overpassBold17: UIFont {
        if let customFont = UIFont(name: "Overpass-Bold", size: 17) {
            return customFont
        } else {
            return .boldSystemFont(ofSize: 17)
        }
    }
    static var overpassSemiBold17: UIFont {
        if let customFont = UIFont(name: "Overpass-SemiBold", size: 17) {
            return customFont
        } else {
            return .boldSystemFont(ofSize: 17)
        }
    }
    static var overpassLight17: UIFont {
        if let customFont = UIFont(name: "Overpass-Light", size: 17) {
            return customFont
        } else {
            return .systemFont(ofSize: 17)
        }
    }
    static var overpassRegular17: UIFont {
        if let customFont = UIFont(name: "Overpass-Regular", size: 17) {
            return customFont
        } else {
            return .systemFont(ofSize: 17)
        }
    }
    static var overpassMedium18: UIFont {
        if let customFont = UIFont(name: "Overpass-Medium", size: 18) {
            return customFont
        } else {
            return .systemFont(ofSize: 18)
        }
    }
    static var overpassMedium20: UIFont {
        if let customFont = UIFont(name: "Overpass-Medium", size: 20) {
            return customFont
        } else {
            return .systemFont(ofSize: 20)
        }
    }
    static var overpassBold20: UIFont {
        if let customFont = UIFont(name: "Overpass-Bold", size: 20) {
            return customFont
        } else {
            return .boldSystemFont(ofSize: 20)
        }
    }
}
