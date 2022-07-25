//
//  Parking.swift
//  Parking
//
//  Created by Maxim on 25.07.2022.
//

//import Foundation


struct Parking {
    let id: Int
    let coordinates: Coordinates
    let adress: String
    let hourCost: Float
    
    struct Coordinates {
        var point: [Double]
        var type: String
        var form: [[Double]]
    }
    
}
