//
//  ProfileHeaderView.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 06.09.2022.
//

import Foundation
import UIKit

final class ProfileHeaderView: UITableViewHeaderFooterView {
    static var reuseIdentifier: String { "\(Self.self)" }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .overpassLight17
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = .clear
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1)
        ])
    }
}

extension ProfileHeaderView {
    func configure(with profileViewModel: ProfileViewModelProtocol, for section: Int) {
        let header = profileViewModel.getHeaderViewModel(for: section)
        titleLabel.text = header
    }
}
