//
//  SpecialNumCell.swift
//  Parking
//
//  Created by mac on 29.08.2022.
//

import UIKit

class SpecialNumberCell: UITableViewCell {
    static var reuseIdentifier: String { "\(Self.self)" }
    static var identifier = "SpecialNumberCell"
    let defaults = UserDefaults.standard
    let tableView = NewCarTableView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        contentView.backgroundColor = .white
        selectionStyle = .none
        defaults.set(switchSpecialCar.isOn, forKey: "isSpecialNumber")
        switchSpecialCar.addTarget(self, action: #selector(switchIsChangeValue), for: .valueChanged)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let switchSpecialCar: UISwitch = {
       let switchCar = UISwitch()
        switchCar.isOn = false
        switchCar.translatesAutoresizingMaskIntoConstraints = false
        return switchCar
    }()
    let labelSpecialNumCar: UILabel = {
       let lable = UILabel()
        lable.textColor = .black
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    @objc func switchIsChangeValue() {
//        defaults.set(switchSpecialCar.isOn, forKey: "isSpecialNumberCar")
    }
    
    
    func setupLayout(){
        contentView.addSubview(labelSpecialNumCar)
        contentView.addSubview(switchSpecialCar)
        NSLayoutConstraint.activate([
            labelSpecialNumCar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelSpecialNumCar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            labelSpecialNumCar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            switchSpecialCar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            switchSpecialCar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            switchSpecialCar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}
