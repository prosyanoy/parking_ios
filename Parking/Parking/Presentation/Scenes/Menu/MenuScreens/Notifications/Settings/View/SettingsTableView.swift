//
//  SettingsTableView.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 17.08.2022.
//

import UIKit

final class SettingsTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContent() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        contentInset = .zero
        allowsSelection = false
        allowsMultipleSelection = false
        delaysContentTouches = true
        contentInsetAdjustmentBehavior = .always
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = true
        isScrollEnabled = true
        separatorStyle = .none
        rowHeight = Constants.rowsHeight
        
        register(SettingsCellView.self, forCellReuseIdentifier: SettingsCellView.reuseIdentifier)
    }
}

extension SettingsTableView {
    private struct Constants {
        static var rowsHeight: CGFloat { 55 }
    }
}
