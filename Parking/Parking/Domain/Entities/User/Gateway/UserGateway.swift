//
//  UserGateway.swift
//  Parking
//
//  Created by Maxim Terpugov on 25.08.2022.
//

protocol UserGateway {
    func fetch() async throws -> User
}
