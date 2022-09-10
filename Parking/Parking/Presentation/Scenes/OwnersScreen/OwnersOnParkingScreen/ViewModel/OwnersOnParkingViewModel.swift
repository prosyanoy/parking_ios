//
//  OwnersOnParkingViewModel.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 28.08.2022.
//

import Foundation

protocol OwnersOnParkingViewModelProtocol {
    
    var parkingDetails: [OnParkingDetailsCell] {get}
    
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection() -> Int
    func getOwnerOnParkingViewModel(for indexPath: IndexPath) -> OnParkingDetailsCell
}

final class OwnersOnParkingViewModel: OwnersOnParkingViewModelProtocol {
    
    
    var parkingDetails = [OnParkingDetailsCell(carNumber: "А743АА 77",
                                               startParkingTime: Date(),
                                               price: 100),
                          OnParkingDetailsCell(carNumber: "К172ММ 29",
                                               startParkingTime: Date(),
                                               price: 500),
                          OnParkingDetailsCell(carNumber: "С920ВР 98",
                                               startParkingTime: Date(),
                                               price: 700)]
    
    func getNumberOfSections() -> Int {
        return parkingDetails.count
    }
    
    func getNumberOfRowsInSection() -> Int {
        return 1
    }
    
    func getOwnerOnParkingViewModel(for indexPath: IndexPath) -> OnParkingDetailsCell {
        let details = parkingDetails[indexPath.section]
        return OnParkingDetailsCell(carNumber: details.carNumber,
                                    startParkingTime: details.startParkingTime,
                                    price: details.price)
    }
}
