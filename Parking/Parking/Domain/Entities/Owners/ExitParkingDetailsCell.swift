//
//  ParkingDetails.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 26.08.2022.
//

import Foundation

struct ExitParkingDetailsCell {
    let carNumber: String
    let startParkingTime: Date
    let price: Int
    let userRating: Int
    let parkingConfirmation: Bool
    
    init(carNumber: String, startParkingTime: Date, price: Int, userRating: Int, parkingConfirmation: Bool) {
        self.carNumber = carNumber
        self.startParkingTime = startParkingTime
        self.price = price
        self.userRating = userRating
        self.parkingConfirmation = parkingConfirmation
    }
}
