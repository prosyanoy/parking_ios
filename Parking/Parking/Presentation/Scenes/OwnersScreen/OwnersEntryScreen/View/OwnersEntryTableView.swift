//
//  OwnersEntryTableView.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 28.08.2022.
//

import Foundation
import UIKit

final class OwnersEntryTableView: UITableView {
    
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
        separatorStyle = .singleLine
        rowHeight = 100
        
        register(OwnersEntryCellView.self, forCellReuseIdentifier: OwnersEntryCellView.reuseIdentifier)
    }
}
