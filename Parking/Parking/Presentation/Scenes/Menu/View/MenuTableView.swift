//
//  MenuTableView.swift
//  Parking
//
//  Created by Sofia Lupeko on 01.08.2022.
//

import UIKit

final class MenuTableView: UITableView {
    
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
        allowsSelection = true
        allowsMultipleSelection = false
        delaysContentTouches = true
        contentInsetAdjustmentBehavior = .always
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = true
        isScrollEnabled = true
        separatorStyle = .none
        rowHeight = Constants.rowsHeight
        
        register(MenuCellView.self, forCellReuseIdentifier: MenuCellView.reuseIdentifier)
        register(MenuHeaderView.self, forHeaderFooterViewReuseIdentifier: MenuHeaderView.reuseIdentifier)
    }
}

extension MenuTableView {
    private struct Constants {
        static var rowsHeight: CGFloat { 68 }
    }
}
