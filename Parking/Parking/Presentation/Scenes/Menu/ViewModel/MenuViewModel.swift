//
//  MenuViewModel.swift
//  Parking
//
//  Created by Sofia Lupeko on 01.08.2022.
//

import Foundation

protocol MenuViewModelProtocol {
    func getCellViewModel(for indexPath: IndexPath) -> MenuCell
    func getHeaderViewModel(for section: Int) -> MenuHeader
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection(section: Int) -> Int
    func menuCellTapped(with model: MenuCell)
}

final class MenuViewModel: MenuViewModelProtocol {
    private let router: MenuRouterProtocol
    
    private let menuInfo = [
        [
            [""],
            ["person.crop.circle","Имя Фамилия"]
        ],
        [
            ["Основные"],
            ["Parking", "Мои стоянки"],
            ["Notifications", "Уведомления"],
            ["News", "Новости"],
            ["Car", "Мои автомобили"]
        ],
        [
            ["Оплата"],
            ["Balance", "Мой счет"],
            ["Fines", "Штрафы и эвакуации"]
        ],
        [
            ["Другое"],
            ["Change", "Изменить город"],
            ["ParkFree", "Паркуйся бесплатно"],
            ["Feedback", "Обратная связь"],
            ["About", "О приложении"]
        ],
    ]
    
    init(router: MenuRouterProtocol) {
        self.router = router
    }
    
    func getNumberOfSections() -> Int {
        return menuInfo.count
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        return menuInfo[section].count - 1
    }
    
    func getHeaderViewModel(for section: Int) -> MenuHeader {
        return MenuHeader(title: menuInfo[section][0][0])
    }
    
    func getCellViewModel(for indexPath: IndexPath) -> MenuCell {
        let numSections = menuInfo.count
        guard indexPath.section < numSections else {
            return MenuCell(iconName: "ERROR", title: "ERROR", rightText: "ERROR")
        }
        let section = menuInfo[indexPath.section]
        let row = indexPath.row + 1
        var rightText: String {
            if section[row][1] == "Изменить город" {
                return "Сочи"
            }
            return ""
        }
        return MenuCell(iconName: section[row][0], title: section[row][1], rightText: rightText)
    }
    
    func menuCellTapped(with model: MenuCell) {
        router.menuCellTapped(with: model)
    }
}
