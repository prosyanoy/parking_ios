//
//  ProfileViewModel.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 06.09.2022.
//

import Foundation

protocol ProfileViewModelProtocol {
    
    var profileInfo: ProfileInfo {get set}
    
    func getCellViewModel(for indexPath: IndexPath) -> String
    func getHeaderViewModel(for section: Int) -> String
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection(section: Int) -> Int
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    var profileInfo = ProfileInfo(surname: "", name: "", patronymic: "", phone: "", email: "")
    
    func getCellViewModel(for indexPath: IndexPath) -> String {
        
        var cellInfo: String = ""
        switch indexPath.section {
        case 0:
            cellInfo = profileInfo.surname ?? ""
        case 1:
            cellInfo = profileInfo.name ?? ""
        case 2:
            cellInfo = profileInfo.patronymic ?? ""
        case 4:
            if profileInfo.email != "" {
                cellInfo = profileInfo.email!
            } else {
                cellInfo = "Необязательно"
            }
        default:
            cellInfo = "Необязательно"
        }
        if indexPath.section == 3 {
            if let phone = UserDefaults.standard.string(forKey: "Phone") {
                cellInfo = "+7 \(phone)"
            }
        }
        if indexPath.section == 5 {
            switch indexPath.row {
            case 0:
                cellInfo = "Удалить учетную запись"
            case 1:
                cellInfo = "Выйти"
            default:
                cellInfo = ""
            }
        }
        return cellInfo
    }
    
    func getHeaderViewModel(for section: Int) -> String {
        var header: String = ""
        switch section {
        case 0:
            header = "Фамилия"
        case 1:
            header = "Имя"
        case 2:
            header = "Отчество"
        default:
            header = ""
        }
        return header
    }
    
    func getNumberOfSections() -> Int {
        return 6
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        if section == 5 {
            return 2
        }
        return 1
    }
}
