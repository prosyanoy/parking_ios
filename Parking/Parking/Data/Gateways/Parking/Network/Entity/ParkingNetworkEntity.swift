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


struct ParkingNetworkEntity: Decodable,
                             DomainConvertable {
    let id: String
    let coordinates: CoordinatesNetworkEntity
    let adress: String
    let hourCost: String
    
    let isClosed: String
    let covered: String
    let secure: String
    let aroundTheClock: String
    let ev: String
    let disabled: String
    
    let costPerHour: [[String : String]]
    let time: [[WorkScheduleNetworkEntity]]
    
    enum CodingKeys: CodingKey {
        case id
        case coordinates
        case address
        case hour_cost
        
        case isClosed
        case covered
        case secure
        case around_the_clock
        case ev
        case disabled
        
        case cost_per_hour
        case time
    }
    
    // MARK: Decodable
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.id = try container.decode(String.self, forKey: .id)
            self.coordinates = try container.decode(CoordinatesNetworkEntity.self, forKey: .coordinates)
            self.adress = try container.decode(String.self, forKey: .address)
            self.hourCost = try container.decode(String.self, forKey: .hour_cost)
            
            self.isClosed = try container.decode(String.self, forKey: .isClosed)
            self.covered = try container.decode(String.self, forKey: .covered)
            self.secure = try container.decode(String.self, forKey: .secure)
            self.aroundTheClock = try container.decode(String.self, forKey: .around_the_clock)
            self.ev = try container.decode(String.self, forKey: .ev)
            self.disabled = try container.decode(String.self, forKey: .disabled)
            
            self.costPerHour = try container.decode([[String : String]].self, forKey: .cost_per_hour)
            self.time = try container.decode([[WorkScheduleNetworkEntity]].self, forKey: .time)
        } catch let error {
            throw error
        }
    }
    
    // MARK: DomainConvertable
    func parseToDomain() throws -> Parking {
        do {
            guard let id = Int(self.id),
                  let hourCost = Float(self.hourCost) else {
                throw ParkingNetworkEntityError.parseToDomain("invalid Parking string format")
            }
            let isClosed = NSString(string: self.isClosed).boolValue
            let covered = NSString(string: self.covered).boolValue
            let secure = NSString(string: self.secure).boolValue
            let aroundTheClock = NSString(string: self.aroundTheClock).boolValue
            let ev = NSString(string: self.ev).boolValue
            let disabled = NSString(string: self.disabled).boolValue
            
            let coordinates = try coordinates.parseToDomain()
            let workSchedule = try time.map { try $0.map { try $0.parseToDomain() } }
            return .init(id: id,
                         coordinates: coordinates,
                         adress: self.adress,
                         hourCost: hourCost,
                         isClosed: isClosed,
                         covered: covered,
                         secure: secure,
                         aroundTheClock: aroundTheClock,
                         ev: ev,
                         disabled: disabled,
                         billing: self.costPerHour,
                         workSchedule: workSchedule)
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
        func parseToDomain() throws -> Parking.Coordinates {
            guard let type = Parking.CoordinateType(rawValue: self.type) else {
                throw ParkingNetworkEntityError.parseToDomain("invalid Coordinate type --> \(self.type)")
            }
            return .init(point: self.point,
                         type: type,
                         form: self.list)
        }
    }
    
    
    struct WorkScheduleNetworkEntity: Decodable,
                                      DomainConvertable {
        let days: String
        let openingTime: String
        let closingTime: String
        let isWorkingToday: String
        
        enum CodingKeys: CodingKey {
            case days
            case open
            case close
            case isWorking
        }
        
        // MARK: Decodable
        init(from decoder: Decoder) throws {
            do {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.days = try container.decode(String.self, forKey: .days)
                self.openingTime = try container.decode(String.self, forKey: .open)
                self.closingTime = try container.decode(String.self, forKey: .close)
                self.isWorkingToday = try container.decode(String.self, forKey: .isWorking)
            } catch let error {
                throw error
            }
        }
        
        // MARK: DomainConvertable
        func parseToDomain() throws -> Parking.WorkSchedule {
            guard let day = Parking.WorkSchedule.Weekday(rawValue: self.days) else {
                throw ParkingNetworkEntityError.parseToDomain("invalid WorkSchedule input type")
            }
            let isWorkingToday = NSString(string: self.isWorkingToday).boolValue
            
            return .init(days: day,
                         openingTime: self.openingTime,
                         closingTime: self.closingTime,
                         isWorkingToday: isWorkingToday)
        }
    }
    
}
