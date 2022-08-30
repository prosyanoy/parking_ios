//
//  User.swift
//  Parking
//
//  Created by Maxim Terpugov on 25.08.2022.
//

import Foundation


struct User {
    let id: UUID
    let email: String
    // баланс кошелька в константу. Изменение только через синхронизацию с беком
    var walletBalance: Float
    var licencePlate: String
}
