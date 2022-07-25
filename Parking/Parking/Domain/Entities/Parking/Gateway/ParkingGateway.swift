//
//  ParkingGateway.swift
//  Parking
//
//  Created by Maxim on 25.07.2022.
//

//import Foundation


protocol ParkingGateway {
    func fetch() async throws -> [Parking]
}
