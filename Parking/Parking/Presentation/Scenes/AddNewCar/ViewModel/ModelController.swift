//
//  ModelController.swift
//  Parking
//
//  Created by mac on 03.09.2022.
//


import UIKit

 
struct NewCarHeader {
    let title: String

    init(title: String) {
        self.title = title
    }
}


//struct NumberCarCellViewModel {
//    let titleNumberCar: String
//    let  plaichonderText: String
//}
//
//struct ForeignNumberCellViewModel{
//    let titleForeignNumber: String
//    var isSelected: Bool
//}
//
//struct NameCarViewModel {
//    let title = "Название"
//}
//
//struct SpecialNumCellViewModel {
//    let titleSpecialNum: String
//}
//
//struct TypeCarCellViewModel {
//    let title = "ТИП АВТОМОБИЛЯ"
//    let name = ["Мотоцикл", "Легковая", "Автобус", "Грузовая"]
//    let imageName = ["Bike (A)", "Car (B)", "Bus (D)", "Truck (C)"]
//}
//
//struct StsCellViewModel {
//    let title = "CTC"
//}

protocol NewCarViewModelProtocol {
    func getCellViewModel(for indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
    func getHeaderViewModel(for section: Int) -> NewCarHeader
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection(section: Int) -> Int
}

class NewCarViewModel: NewCarViewModelProtocol {
    
    let defaults = UserDefaults.standard
    private let newCarInfo = [
          [
            ["Новый автомобиль"],
            ["A  000  AA 000"],
            ["Иностранный/специальный номер"],
            ["Название"]
          ],
          [
            ["ТИП АВТОМОБИЛЯ"],
            ["Bike (A)", "Мотоцикл"],
            ["Car (B)", "Легковая"],
            ["Bus (D)", "Автобус"],
            ["Truck (C)", "Грузовая"]
          ],
          [
            [""],
            ["CTC"]
          ],
      ]
    
    
    func getCellViewModel(for indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: NumberCarCell.identifier, for: indexPath) as? NumberCarCell else {
                        return NumberCarCell()
                    }
                    return cell
            case 1:
                guard let specialNumCell = tableView.dequeueReusableCell(withIdentifier: SpecialNumberCell.identifier, for: indexPath)
                        as? SpecialNumberCell else {
                    return SpecialNumberCell()
                }
                
                print(specialNumCell.switchSpecialCar.isOn)
                 
                specialNumCell.labelSpecialNumCar.text = "Иностранный/специальный номер"
                return specialNumCell
            case 2:
                guard let numeSarCell = tableView.dequeueReusableCell(withIdentifier: StsCell.identifier, for: indexPath)
                        as? StsCell else {
                    return UITableViewCell()
                }
                numeSarCell.stsAndNameCarLabel.text = "Название"
                return numeSarCell
            default:
                break
            }
        case 1:
            guard let typeCarCell = tableView.dequeueReusableCell(withIdentifier: TypeCarCell.identifier, for: indexPath)
                    as? TypeCarCell else {
                return UITableViewCell()
            }
            for index in 0...indexPath.row {
                typeCarCell.typeCarLabel.text = newCarInfo[indexPath.section][index + 1][1]
                typeCarCell.imageTypeCar.image = UIImage(named: newCarInfo[indexPath.section][index + 1][0])
                
            }
            if typeCarCell.name[indexPath.row] == defaults.string(forKey: "typeOfCar") {
                typeCarCell.checkCarlabel.isHidden = false
            } else {
                typeCarCell.checkCarlabel.isHidden = true
            }
            return typeCarCell
        case 2:
            guard let stsCell = tableView.dequeueReusableCell(withIdentifier:
                StsCell.identifier, for: indexPath)
                    as? StsCell else {
                return UITableViewCell()
            }
            stsCell.stsAndNameCarLabel.text = "CTC"
            return stsCell
        default:
            break
            }
        return UITableViewCell()
    }
    
    func getHeaderViewModel(for section: Int) -> NewCarHeader {
        switch section {
        case 0:
            return NewCarHeader(title: "Новый автомобиль")
        case 1:
            return NewCarHeader(title: "ТИП АВТОМОБИЛЯ")
       default:
            return NewCarHeader(title: "")
        }
//        return NewCarHeader(title: newCarInfo[section][0][0])
    }
    
    func getNumberOfSections() -> Int {
        newCarInfo.count
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        newCarInfo[section].count - 1
    }
}
    
    
    
    
   
