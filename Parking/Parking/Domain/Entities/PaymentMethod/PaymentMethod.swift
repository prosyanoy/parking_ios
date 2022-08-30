//
//  PaymentMethod.swift
//  Parking
//
//  Created by Maxim Terpugov on 24.08.2022.
//

import Foundation


struct PaymentMethod {
    let title: String
    let description: String
    var icon: Data?
    let signature: Signature
    
    enum Signature: String {
        case card = "Банковская карта"
        case sbp = "Система быстрых платежей"
        case none = ""
    }
}
