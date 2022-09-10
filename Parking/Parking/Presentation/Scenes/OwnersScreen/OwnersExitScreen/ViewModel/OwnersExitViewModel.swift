//
//  OwnersExitViewModel.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 27.08.2022.
//

import Foundation

protocol OwnersExitViewModelProtocol {
    
    var parkingDetails: [ExitParkingDetailsCell] {get}
    
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection() -> Int
    func getOwnerExitViewModel(for indexPath: IndexPath) -> ExitParkingDetailsCell
}

final class OwnersExitViewModel: OwnersExitViewModelProtocol {
    
    var parkingDetails = [ExitParkingDetailsCell(carNumber: "A757AA 777",
                                                 startParkingTime: Date(),
                                                 price: 300,
                                                 userRating: 4,
                                                 parkingConfirmation: true),
                          ExitParkingDetailsCell(carNumber: "К129ВУ 777",
                                                 startParkingTime: Date(),
                                                 price: 100,
                                                 userRating: 5,
                                                 parkingConfirmation: true),
                          ExitParkingDetailsCell(carNumber: "Т754НН 777",
                                                 startParkingTime: Date(),
                                                 price: 2000,
                                                 userRating: 2,
                                                 parkingConfirmation: true)]
    
    func getNumberOfSections() -> Int {
        return parkingDetails.count
    }
    
    func getNumberOfRowsInSection() -> Int {
        return 1
    }
    
    func getOwnerExitViewModel(for indexPath: IndexPath) -> ExitParkingDetailsCell {
        let details = parkingDetails[indexPath.section]
        return ExitParkingDetailsCell(carNumber: details.carNumber,
                                      startParkingTime: details.startParkingTime,
                                      price: details.price,
                                      userRating: details.userRating,
                                      parkingConfirmation: details.parkingConfirmation)
    }
}
