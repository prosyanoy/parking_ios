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
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
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
        register(ProfileDeleteCell.self, forCellReuseIdentifier: ProfileDeleteCell.reuseIdentifier)
        register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.reuseIdentifier)
        register(ProfileTitleCell.self, forCellReuseIdentifier: ProfileTitleCell.reuseIdentifier)
    }
}

extension ProfileTableView {
    private struct Constants {
        static var rowsHeight: CGFloat { 45 }
    }
}
