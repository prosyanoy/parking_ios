//
//  SettingsCellView.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 16.08.2022.
//

import UIKit

final class SettingsCellView: UITableViewCell {
    
    static var reuseIdentifier: String { "\(Self.self)" }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .overpassRegular17
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()
    
    let switchHandler: UISwitch = {
        let switchHandler = UISwitch()
        switchHandler.onTintColor = UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1)
        return switchHandler
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        accessoryView = switchHandler
        
    }
    
    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(switchHandler)
        
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60)
        ])
    }
}

extension SettingsCellView {
    func configure(with settingsViewModel: SettingsViewModelProtocol, for indexPath: IndexPath) {
        let cell = settingsViewModel.getCellViewModel(for: indexPath)
        
        titleLabel.text = cell.title
    }
}

