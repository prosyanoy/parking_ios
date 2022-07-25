//
//  ParkingNetworkRepository.swift
//  Parking
//
//  Created by Maxim on 25.07.2022.
//

import Foundation
import BabyNet


protocol ParkingNetworkRepositoryProtocol {
    func fetch(callback: @escaping (Result<[ParkingNetworkEntity], Error>) -> Void) -> URLSessionTask?
}


final class ParkingNetworkRepository: ParkingNetworkRepositoryProtocol {
    
    // MARK: - Dependencies

    private let client: BabyNetRepositoryProtocol
//    private let apiKey: String
    
    
    // MARK: - Init

    init(client: BabyNetRepositoryProtocol) {
        self.client = client
    }
    
    
    // MARK: - Interface

    func fetch(callback: @escaping (Result<[ParkingNetworkEntity], Error>) -> Void) -> URLSessionTask? {
        let url = BabyNetURL(scheme: .https,
                             host: "pros.sbs",
                             path: "/parking/getting.php",
                             endPoint: ["apicall" : "get_parkings"])
        let request = BabyNetRequest(method: .get,
                                     header: nil,
                                     body: nil)
        let session = BabyNetSession.default
        let decoderType = [ParkingNetworkEntity].self
        return client.connect(url: url,
                              request: request,
                              session: session,
                              decoderType: decoderType,
                              observationCallback: nil,
                              taskProgressCallback: nil,
                              responseCallback: callback)
    }
    
    
}
