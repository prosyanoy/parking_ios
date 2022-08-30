//
//  PaymentMethodGateway.swift
//  Parking
//
//  Created by Maxim Terpugov on 24.08.2022.
//

protocol PaymentMethodGateway {
    func fetch() async throws -> [PaymentMethod]
}
