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
    
    var profileInfo = ProfileInfo(surname: nil, name: nil, patronymic: nil, phone: nil, email: nil)
    
    func getCellViewModel(for indexPath: IndexPath) -> String {
        
        var cellInfo: String = ""
        switch indexPath.section {
        case 0:
            cellInfo = (profileInfo.name ?? "Имя") + " " + (profileInfo.surname ?? "Фамилия")
        case 1:
            cellInfo = profileInfo.surname ?? ""
        case 2:
            cellInfo = profileInfo.name ?? ""
        case 3:
            cellInfo = profileInfo.patronymic ?? ""
        case 4:
            let phone = UserDefaultsDataManager.userPhoneNumber
            cellInfo = "+7 \(phone)"
        case 5:
            if profileInfo.email != nil {
                cellInfo = profileInfo.email!
            } else {
                cellInfo = "email@example.ru"
            }
        case 6:
            cellInfo = "Удалить учетную запись"
        default:
            cellInfo = "Необязательно"
        }
        return cellInfo
    }
    
    func getHeaderViewModel(for section: Int) -> String {
        var header: String = ""
        switch section {
        case 1:
            header = "Фамилия"
        case 2:
            header = "Имя"
        case 3:
            header = "Отчество"
        case 4:
            header = "Телефон"
        case 5:
            header = "Электронная почта"
        default:
            header = ""
        }
        return header
    }
    
    func getNumberOfSections() -> Int {
        return 7
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        return 1
    }
}
