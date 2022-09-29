//
//  SettingsViewModel.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 17.08.2022.
//

import UIKit

protocol SettingsViewModelProtocol {
    func getCellViewModel(for indexPath: IndexPath) -> SettingsCell
    func getNumberOfRowsInSection(section: Int) -> Int
}

final class SettingsViewModel: SettingsViewModelProtocol {
    
    private let settingsInfo = [
        ["За 10 минут до начала брони"],
        ["В момент начала брони"],
        ["За 10 минут до конца стоянки"],
        ["В момент окончания стоянки"],
        ["При удалении от места парковки"]
    ]
    
    func getCellViewModel(for indexPath: IndexPath) -> SettingsCell {
        let numSections = settingsInfo.count
        guard indexPath.section < numSections else {
            return SettingsCell(title: "ERROR")
        }
        return SettingsCell(title: settingsInfo[indexPath.row][0])
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        return settingsInfo.count
    }
}
