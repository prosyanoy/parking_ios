//
//  ProfileViewModel.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 06.09.2022.
//

import Foundation

protocol ProfileViewModelProtocol {
    func getCellViewModel(for indexPath: IndexPath) -> SettingsCell
    func getHeaderViewModel(for section: Int) -> SettingsHeader
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection(section: Int) -> Int
}

final class ProfileViewModel: ProfileViewModelProtocol {
   
    private let profileInfo = [
            "Фамилия",
            "Имя",
            "Отчество",
            "Телефон",
            "E-mail",
            "Удалить учетную запись",
            "Выйти"
    ]
    
    func getCellViewModel(for indexPath: IndexPath) -> SettingsCell {
        let numSections = profileInfo.count
        guard indexPath.section < numSections else {
            return SettingsCell(title: "ERROR")
        }
        let section = profileInfo[indexPath.section]
        return SettingsCell(title: section)
    }
    
    func getHeaderViewModel(for section: Int) -> SettingsHeader {
        return SettingsHeader(title: profileInfo[section].uppercased())
    }
    
    func getNumberOfSections() -> Int {
        return profileInfo.count
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        return profileInfo[section].count - 1
    }
}
