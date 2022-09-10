//
//  OnParkingDetailsCell.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 28.08.2022.
//

import Foundation

struct OnParkingDetailsCell {
    let carNumber: String
    let startParkingTime: Date
    let price: Int
    
    init(carNumber: String, startParkingTime: Date, price: Int) {
        self.carNumber = carNumber
        self.startParkingTime = startParkingTime
        self.price = price
    }
}
