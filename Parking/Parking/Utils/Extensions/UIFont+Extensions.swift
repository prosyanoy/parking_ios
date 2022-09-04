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
}
