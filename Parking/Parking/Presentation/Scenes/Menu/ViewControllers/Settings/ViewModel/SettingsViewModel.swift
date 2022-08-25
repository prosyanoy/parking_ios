//
//  SettingsViewModel.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 17.08.2022.
//

import UIKit

protocol SettingsViewModelProtocol {
    func getCellViewModel(for indexPath: IndexPath) -> SettingsCell
    func getHeaderViewModel(for section: Int) -> SettingsHeader
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection(section: Int) -> Int
}

final class SettingsViewModel: SettingsViewModelProtocol {
    
    private let settingsInfo = [
        [
            ["Оповещать"],
            ["За 15 минут до конца оплаченного времени парковки"],
            ["В момент окончания парковки"],
            ["При удалении от места парковки"]
        ],
        [
            ["Показать на карте"],
            ["Парковка для автомобилей инвалидов"]
        ],
        [
            ["Вход в приложение"],
            ["Использовать пин-код"],
            ["Face ID"]
        ],
    ]
    
    func getCellViewModel(for indexPath: IndexPath) -> SettingsCell {
        let numSections = settingsInfo.count
        guard indexPath.section < numSections else {
            return SettingsCell(title: "ERROR")
        }
        let section = settingsInfo[indexPath.section]
        let row = indexPath.row + 1
        return SettingsCell(title: section[row][0])
    }
    
    func getHeaderViewModel(for section: Int) -> SettingsHeader {
        return SettingsHeader(title: settingsInfo[section][0][0].uppercased())
    }
    
    func getNumberOfSections() -> Int {
        return settingsInfo.count
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        return settingsInfo[section].count - 1
    }
}
