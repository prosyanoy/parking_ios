//
//  AddCarViewController.swift
//  Parking
//
//  Created by Denis Zagudaev on 21.08.2022.
//

import UIKit

protocol NewCarConfigurationViewModelProtocol {

}



class NewCarViewController: UIViewController, NewCarConfigurationViewModelProtocol {
    
    var newCarTableView = UITableView()
    private var typeOfCar: String?
    private var isForeignNumber = false
    
    
    let labelAddCar: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        label.text = "Новый автомобиль"
        label.textColor = .darkGray
        return label
    }()
    
    let addNewUserButton: UIButton = {
        let button = UIButton()
        let buttonColorOn = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(buttonColorOn, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        createTable()
        layoutNewUserButtonAndLable()
        setTarget()
        
        newCarTableView.register(NumberCarCell.self, forCellReuseIdentifier: NumberCarCell.reuseIdentifier)
        newCarTableView.register(NameCarCell.self, forCellReuseIdentifier: NameCarCell.reuseIdentifier)
        newCarTableView.register(StsCell.self, forCellReuseIdentifier: StsCell.reuseIdentifier)
        newCarTableView.register(TypeCarCell.self, forCellReuseIdentifier: TypeCarCell.reuseIdentifier)
        newCarTableView.register(SpecialNumberCell.self, forCellReuseIdentifier: SpecialNumberCell.reuseIdentifier)
        newCarTableView.register(ForeignNumberCell.self, forCellReuseIdentifier: ForeignNumberCell.reuseIdentifier)
        
        newCarTableView.addSubview(addNewUserButton)
        newCarTableView.addSubview(labelAddCar)
        addNewUserButton.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as? UITouch {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
    func layoutNewUserButtonAndLable() {
        
        NSLayoutConstraint.activate([
            addNewUserButton.topAnchor.constraint(equalTo: newCarTableView.topAnchor),
            addNewUserButton.trailingAnchor.constraint(equalTo: newCarTableView.trailingAnchor, constant: -20),
            labelAddCar.centerXAnchor.constraint(equalTo: newCarTableView.centerXAnchor),
            labelAddCar.topAnchor.constraint(equalTo: newCarTableView.topAnchor, constant: 12),
        ])
    }
    
    func setTarget() {
        addNewUserButton.addTarget(self, action: #selector(addNewCar(_:)), for: .touchUpInside)
    }
    
    @objc func addNewCar(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension NewCarViewController: UITableViewDataSource, UITableViewDelegate {
    
    func createTable() {
        self.newCarTableView = UITableView(frame: view.bounds, style: .insetGrouped)
        newCarTableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        newCarTableView.delegate = self
        newCarTableView.dataSource = self
        view.addSubview(newCarTableView)
        view.addSubview(addNewUserButton)
        view.addSubview(labelAddCar)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
            3
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 4
        case 2:
            return 1
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        // - add number car section
            
        case 0:
            
            // - add Number Text Field
            
            switch indexPath.row {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: NumberCarCell.reuseIdentifier, for: indexPath) as? NumberCarCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                return cell
                
            // - special num
                
            case 1:
                guard let specialNumCell = tableView.dequeueReusableCell(withIdentifier: SpecialNumberCell.reuseIdentifier, for: indexPath)
                        as? SpecialNumberCell else {
                    return UITableViewCell()
                }
                 
                specialNumCell.labelSpecialNumCar.text = "Иностранный/специальный номер"
                return specialNumCell
                
            // - name of car
                
            case 2:
                guard let numeSarCell = tableView.dequeueReusableCell(withIdentifier: StsCell.reuseIdentifier, for: indexPath)
                        as? StsCell else {
                    return UITableViewCell()
                }
                numeSarCell.stsAndNameCarLabel.text = "Название"
                return numeSarCell
            default:
                break
            }
        // - Type of car section
            
        case 1:
            guard let typeCarCell = tableView.dequeueReusableCell(withIdentifier: TypeCarCell.reuseIdentifier, for: indexPath)
                    as? TypeCarCell else {
                return UITableViewCell()
            }
            for index in 0...indexPath.row {
                typeCarCell.typeCarLabel.text = typeCarCell.name[index]
                typeCarCell.imageTypeCar.image = UIImage(named: typeCarCell.types[index])
                
            }
            if typeCarCell.name[indexPath.row] == typeOfCar {
                typeCarCell.checkCarlabel.isHidden = false
            } else {
                typeCarCell.checkCarlabel.isHidden = true
            }
            return typeCarCell
            
        // - add STS section
            
        case 2:
            guard let stsCell = tableView.dequeueReusableCell(withIdentifier:
                StsCell.reuseIdentifier, for: indexPath)
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
}

extension NewCarViewController {
    
    // - header and footer text
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
   
        switch section {
        case 0:
            
            header.textLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 15)
            header.textLabel?.textColor = .darkGray
            header.textLabel?.textAlignment = .center
        case 1:
            header.textLabel?.textColor = .darkGray
            header.textLabel?.textAlignment = .left
        case 2:
            
            header.textLabel?.textColor = .darkGray
            header.textLabel?.textAlignment = .center
        default:
            break
        }
    }
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return "ТИП АВТОМОБИЛЯ"
        case 2:
            return ""
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return ""
        case 2:
            return "Укажите серию и номер свидетельства о регистрации ТС и узнавайте о штрафах"
        default:
            return nil
        }
    }
    
    // - type of car check
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let typeCarCell = tableView.dequeueReusableCell(withIdentifier:
            TypeCarCell.reuseIdentifier, for: indexPath)
                as? TypeCarCell else {
            return
        }
        typeOfCar = typeCarCell.name[indexPath.row]
        tableView.reloadData()
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        guard let specialNumCell = tableView.dequeueReusableCell(withIdentifier: SpecialNumCell.identifier, for: indexPath)
//                      as? SpecialNumCell else {
//                  return
//              }
//              if specialNumCell.switchSpecialCar.isOn == true {
//                  foreighNumOrNot = true
//                  print(foreighNumOrNot)
//                  tableView.reloadData()
//              } else {
//                  foreighNumOrNot = false
//                  print(foreighNumOrNot)
//                  tableView.reloadData()
//              }
//    }
    
}
    

protocol SwitchSpesialCarProtocol: class {
    func isforeighNumOrNot(switchSC: UISwitch)
}


extension NewCarViewController: SwitchSpesialCarProtocol {
    func isforeighNumOrNot(switchSC: UISwitch) {
        
    }
    
}
