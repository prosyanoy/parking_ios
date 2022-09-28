//
//  Parking.swift
//  Parking
//
//  Created by Maxim on 25.07.2022.
//


struct Parking {
    
    let id: Int
    let coordinates: Coordinates
    let adress: String
    let hourCost: Float
    
    struct Coordinates {
        var point: [Double]
        var type: CoordinateType
        var form: [[Double]]
    }
    
    enum CoordinateType: String {
        case polyGon = "g"
        case polyLine = "l"
    }

    let isClosed: Bool
    let covered: Bool
    let secure: Bool
    let aroundTheClock: Bool
    let ev: Bool
    let disabled: Bool
    // тарификация и график работы биндятся между собой по соотнощению массивов 1:1 или 2:2 или 3:3, максимум 7:7, т.е. каждому массиву с днями недели, соответствует каждый массив тарификации с тем же индексом
    // Пока так!
    let billing: [[String : Int]]
    let workSchedule: [[WorkSchedule]]
    
    struct WorkSchedule {
        let days: Weekday
        let openingTime: String
        let closingTime: String
        let isWorkingToday: Bool
        
        enum Weekday: String {
            case monday = "1"
            case tuesday = "2"
            case wednesday = "3"
            case thursday = "4"
            case friday = "5"
            case saturday = "6"
            case sunday = "0"
        }
    }
    
}
