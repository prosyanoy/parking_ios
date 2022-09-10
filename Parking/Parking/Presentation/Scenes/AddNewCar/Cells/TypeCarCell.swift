//
//  TypeCarViewCell.swift
//  Parking
//
//  Created by Denis Zagudaev on 24.08.2022.
//

import UIKit

class TypeCarCell: UITableViewCell {
    static var reuseIdentifier: String { "\(Self.self)" }
    static var identifier = "TypeCarCell"
    let name = ["Мотоцикл", "Легковая", "Автобус", "Грузовая"]
    let types = ["Bike (A)", "Car (B)", "Bus (D)", "Truck (C)"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        contentView.backgroundColor = .white
        selectionStyle = .none
        checkCarlabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageTypeCar: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let typeCarLabel: UILabel = {
       let lable = UILabel()
        lable.textColor = .black
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    let checkCarlabel: UILabel = {
       let lable = UILabel()
        lable.textColor = .blue
        lable.font = UIFont.systemFont(ofSize: 25)
        lable.text = "✓"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    func setupLayout(){
        contentView.addSubview(typeCarLabel)
        contentView.addSubview(imageTypeCar)
        contentView.addSubview(checkCarlabel)
        NSLayoutConstraint.activate([
            typeCarLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            typeCarLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            typeCarLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            imageTypeCar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageTypeCar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageTypeCar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            checkCarlabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -44),
            checkCarlabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            checkCarlabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}
