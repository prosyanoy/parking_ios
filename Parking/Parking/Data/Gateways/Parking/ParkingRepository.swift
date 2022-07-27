//
//  ParkingRepository.swift
//  Parking
//
//  Created by Maxim on 25.07.2022.
//

import Foundation


final class ParkingRepository: ParkingGateway {
    
    // MARK: - Dependencies
    
    private let network: ParkingNetworkRepositoryProtocol
    
    
    // MARK: - Init

    init(network: ParkingNetworkRepository) {
        self.network = network
    }
    
    
    // MARK: - Interface

    func fetch() async throws -> [Parking] {
        let networkParkingEntities = try await withCheckedThrowingContinuation {
            (continuation: CheckedContinuation<[ParkingNetworkEntity], Error>) -> Void in
            let _ = self.network.fetch { result in
                switch result {
                case let .success(parkings):
                    continuation.resume(returning: parkings)
                case let .failure(networkError):
                    // -- map here to Domain Error --
                    // -- then throw Domain Error --
                    continuation.resume(throwing: networkError)
                }
            }
        }
        let domainEntities = try networkParkingEntities.map { try $0.parseToDomain() }
        return domainEntities
    }
    
}
