//
//  NewCarTableView.swift
//  Parking
//
//  Created by mac on 11.09.2022.
//

import UIKit

final class NewCarTableView: UITableView {
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContent() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        contentInset = .zero
        allowsSelection = true
        allowsMultipleSelection = false
        delaysContentTouches = true
        contentInsetAdjustmentBehavior = .always
        showsHorizontalScrollIndicator = true
        showsVerticalScrollIndicator = true
        isScrollEnabled = false
        separatorStyle = .singleLine
        rowHeight = Constants.rowsHeight
        
        register(NumberCarCell.self, forCellReuseIdentifier: NumberCarCell.reuseIdentifier)
        register(ForeignNumberCell.self, forCellReuseIdentifier: ForeignNumberCell.reuseIdentifier)
        register(SpecialNumberCell.self, forCellReuseIdentifier: SpecialNumberCell.reuseIdentifier)
        register(NameCarCell.self, forCellReuseIdentifier: NameCarCell.reuseIdentifier)
        register(TypeCarCell.self, forCellReuseIdentifier: TypeCarCell.reuseIdentifier)
        register(StsCell.self, forCellReuseIdentifier: StsCell.reuseIdentifier)

    }
}

extension NewCarTableView {
    private struct Constants {
        static var rowsHeight: CGFloat { 44 }
    }
}

