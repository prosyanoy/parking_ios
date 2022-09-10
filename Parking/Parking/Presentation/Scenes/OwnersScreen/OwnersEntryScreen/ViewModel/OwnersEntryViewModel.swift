//
//  OwnersEntryViewModel.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 28.08.2022.
//

import Foundation

protocol OwnersEntryViewModelProtocol {
    
    var parkingDetails: [EntryParkingDetailsCell] {get}
    
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection() -> Int
    func getOwnerEntryViewModel(for indexPath: IndexPath) -> EntryParkingDetailsCell
}

final class OwnersEntryViewModel: OwnersEntryViewModelProtocol {
    
    
    var parkingDetails = [EntryParkingDetailsCell(carNumber: "К001ТТ 51",
                                                  startParkingTime: Date(),
                                                  price: 1000),
                          EntryParkingDetailsCell(carNumber: "Р189АУ 35",
                                                  startParkingTime: Date(),
                                                  price: 300),
                          EntryParkingDetailsCell(carNumber: "У643МС 71",
                                                  startParkingTime: Date(),
                                                  price: 250)]
    
    func getNumberOfSections() -> Int {
        return parkingDetails.count
    }
    
    func getNumberOfRowsInSection() -> Int {
        return 1
    }
    
    func getOwnerEntryViewModel(for indexPath: IndexPath) -> EntryParkingDetailsCell {
        let details = parkingDetails[indexPath.section]
        return EntryParkingDetailsCell(carNumber: details.carNumber,
                                       startParkingTime: details.startParkingTime,
                                       price: details.price)
    }
}
