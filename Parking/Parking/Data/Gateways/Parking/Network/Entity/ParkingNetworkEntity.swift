//
//  ParkingNetworkEntity.swift
//  Parking
//
//  Created by Maxim on 25.07.2022.
//

import Foundation


// Error
enum ParkingNetworkEntityError: Error {
    case failedDecoding(String)
    case parseToDomain(String)
}



protocol DomainConvertable {
    associatedtype DomainEntity
    func parseToDomain() throws -> DomainEntity
}


struct ParkingNetworkEntity: Codable,
                             DomainConvertable {
    
    let id: String
    let coordinates: CoordinatesNetworkEntity
    let adress: String
    let hourCost: String
    
    enum CodingKeys: CodingKey {
        case id
        case coordinates
        case address
        case hour_cost
    }
    
    // MARK: Codable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(coordinates, forKey: .coordinates)
        try container.encode(adress, forKey: .address)
        try container.encode(hourCost, forKey: .hour_cost)
    }
    
    
    // MARK: Decodable
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let jsonCoordinates = try container.decode(String.self, forKey: .coordinates)
            guard let dataCoordinates = jsonCoordinates.data(using: .utf8) else {
                throw ParkingNetworkEntityError.failedDecoding("failed json data encoding")
            }
            self.coordinates = try JSONDecoder().decode(CoordinatesNetworkEntity.self, from: dataCoordinates)
            self.id = try container.decode(String.self, forKey: .id)
            self.adress = try container.decode(String.self, forKey: .address)
            self.hourCost = try container.decode(String.self, forKey: .hour_cost)
        } catch let error {
            throw error
        }
    }
    
    
    // MARK: DomainConvertable
    func parseToDomain() throws -> Parking {
        do {
            guard let id = Int(self.id),
                  let hourCost = Float(self.hourCost) else {
                      throw ParkingNetworkEntityError.parseToDomain("invalid string format")
                  }
            let coordinates = coordinates.parseToDomain()
            return .init(id: id,
                         coordinates: coordinates,
                         adress: self.adress,
                         hourCost: hourCost)
        } catch let error {
            throw error
        }
    }
    
    
    
    struct CoordinatesNetworkEntity: Codable,
                                     DomainConvertable {
        let point: [Double]
        let type: String
        let list: [[Double]]
        
        enum CodingKeys: CodingKey {
            case point
            case type
            case list
        }
        
        // MARK: Codable
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(point, forKey: .point)
            try container.encode(type, forKey: .type)
            try container.encode(list, forKey: .list)
        }
        
        // MARK: Decodable
        init(from decoder: Decoder) throws {
            do {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.point = try container.decode([Double].self, forKey: .point)
                self.type = try container.decode(String.self, forKey: .type)
                self.list = try container.decode([[Double]].self, forKey: .list)
            } catch let error {
                throw error
            }
        }
        
        // MARK: DomainConvertable
        func parseToDomain() -> Parking.Coordinates {
            return .init(point: self.point,
                         type: self.type,
                         form: self.list)
        }
    }
    
}


