//
//  OwnersOnParkingCellView.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 28.08.2022.
//

import Foundation
import UIKit

final class OwnersOnParkingCellView: UITableViewCell {
    
    static var reuseIdentifier: String { "\(Self.self)" }
    
    private let carNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .overpassBold17
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    private let startParkingTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .overpassMedium17
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .overpassMedium17
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        contentView.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        carNumberLabel.text = nil
        startParkingTimeLabel.text = nil
        priceLabel.text = nil
    }
    
    private func setupLayout() {
        addSubview(carNumberLabel)
        addSubview(startParkingTimeLabel)
        addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            
            carNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            carNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            carNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            startParkingTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            startParkingTimeLabel.topAnchor.constraint(equalTo: carNumberLabel.bottomAnchor, constant: 16),
            
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            priceLabel.topAnchor.constraint(equalTo: carNumberLabel.bottomAnchor, constant: 16)
            
        ])
    }
}

extension OwnersOnParkingCellView {
    func configure(with onParkingCellViewModel: OwnersOnParkingViewModelProtocol, for indexPath: IndexPath) {
        let cell = onParkingCellViewModel.getOwnerOnParkingViewModel(for: indexPath)
        carNumberLabel.text = cell.carNumber
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let startPakingTime = formatter.string(from: cell.startParkingTime)
        startParkingTimeLabel.text = "c \(startPakingTime)"
        priceLabel.text = "\(cell.price)₽"
    }
}
