//
//  ProfileTableView.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 06.09.2022.
//

import Foundation
import UIKit

final class ProfileTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContent() {
        let lightGrayBackgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = lightGrayBackgroundColor
        contentInset = .zero
        allowsSelection = true
        allowsMultipleSelection = false
        delaysContentTouches = true
        contentInsetAdjustmentBehavior = .always
        showsHorizontalScrollIndicator = false
        isScrollEnabled = false
        separatorStyle = .none
        rowHeight = Constants.rowsHeight
        sectionFooterHeight = 0
        
        register(ProfileNameCell.self, forCellReuseIdentifier: ProfileNameCell.reuseIdentifier)
        register(ProfileEmailPhoneCell.self, forCellReuseIdentifier: ProfileEmailPhoneCell.reuseIdentifier)
        register(ProfileDeleteLogoutCell.self, forCellReuseIdentifier: ProfileDeleteLogoutCell.reuseIdentifier)
        register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.reuseIdentifier)
    }
}

extension ProfileTableView {
    private struct Constants {
        static var rowsHeight: CGFloat { 50 }
    }
}
