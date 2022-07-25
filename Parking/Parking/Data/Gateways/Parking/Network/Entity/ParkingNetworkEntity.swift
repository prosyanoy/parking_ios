//
//  ParkingNetworkEntity.swift
//  Parking
//
//  Created by Maxim on 25.07.2022.
//

import Foundation


// Error
enum ParkingNetworkEntityError: Error {
    case parseToDomain(String)
}



protocol DomainConvertable {
    associatedtype DomainEntity
    func parseToDomain() throws -> DomainEntity
}


struct ParkingNetworkEntity: Codable,
                             DomainConvertable {
    
    let id: String
    let coordinates: String // [String : Any] - not valid decoding type
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
            self.id = try container.decode(String.self, forKey: .id)
            //Coordinates парсится через доп сериализацию JsonObject
            self.coordinates = try container.decode(String.self, forKey: .coordinates)
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
            guard let data = self.coordinates.data(using: .utf8) else {
                throw ParkingNetworkEntityError.parseToDomain("invalid data encoding")
            }
            guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                throw ParkingNetworkEntityError.parseToDomain("invalid data format")
            }
            var coordinates = Parking.Coordinates(point: [0],
                                                 type: "",
                                                 form: [[0]])
            try jsonArray.forEach { key, _ in
                if key == "point" {
                    if let point = jsonArray["point"] as? [Double] {
                        coordinates.point = point
                    } else {
                        throw ParkingNetworkEntityError.parseToDomain("invalid json format")
                    }
                } else if key == "type" {
                    if let type = jsonArray["type"] as? String {
                        coordinates.type = type
                    } else {
                        throw ParkingNetworkEntityError.parseToDomain("invalid json format")
                    }
                } else if key == "list" {
                    if let form = jsonArray["list"] as? [[Double]] {
                        coordinates.form = form
                    } else {
                        throw ParkingNetworkEntityError.parseToDomain("invalid json format")
                    }
                }
            }
            
            let parking = Parking(id: id,
                                  coordinates: coordinates,
                                  adress: self.adress,
                                  hourCost: hourCost)
            print("parking == \(parking) \n \n")
            return parking
            
        } catch let error {
            throw error
        }
    }
    
}
