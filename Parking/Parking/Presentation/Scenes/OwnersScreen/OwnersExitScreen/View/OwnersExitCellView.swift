//
//  OwnersExitCellView.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 26.08.2022.
//

import Foundation
import UIKit
import Cosmos

final class OwnersExitCellView: UITableViewCell {
    
    static var reuseIdentifier: String { "\(Self.self)" }
    
    let carNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .overpassBold17
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    let userRatingView: CosmosView = {
        let view = CosmosView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    let confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .green
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()
    
    private let parkingConfirm: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .center
        return stack
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
        contentView.addSubview(userRatingView)
        addSubview(startParkingTimeLabel)
        addSubview(priceLabel)
        parkingConfirm.addArrangedSubview(confirmButton)
        parkingConfirm.addArrangedSubview(cancelButton)
        contentView.addSubview(parkingConfirm)
        
        NSLayoutConstraint.activate([
            carNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            carNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            userRatingView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            userRatingView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            startParkingTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            startParkingTimeLabel.topAnchor.constraint(equalTo: carNumberLabel.bottomAnchor, constant: 16),
            
            priceLabel.leadingAnchor.constraint(equalTo: startParkingTimeLabel.trailingAnchor, constant: 20),
            priceLabel.topAnchor.constraint(equalTo: carNumberLabel.bottomAnchor, constant: 16),
            
            parkingConfirm.centerXAnchor.constraint(equalTo: userRatingView.centerXAnchor),
            parkingConfirm.topAnchor.constraint(equalTo: userRatingView.bottomAnchor, constant: 16)
            
        ])
    }
}

extension OwnersExitCellView {
    func configure(with exitCellViewModel: OwnersExitViewModelProtocol, for indexPath: IndexPath) {
        let cell = exitCellViewModel.getOwnerExitViewModel(for: indexPath)
        carNumberLabel.text = cell.carNumber
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let startPakingTime = formatter.string(from: cell.startParkingTime)
        startParkingTimeLabel.text = "c \(startPakingTime)"
        userRatingView.rating = Double(cell.userRating)
        priceLabel.text = "\(cell.price)₽"
    }
}
