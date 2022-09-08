//
//  SettingsHeaderView.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 17.08.2022.
//

import UIKit

final class SettingsHeaderView: UITableViewHeaderFooterView {
    static var reuseIdentifier: String { "\(Self.self)" }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
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
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}

extension SettingsHeaderView {
    func configure(with settingsViewModel: SettingsViewModelProtocol, for section: Int) {
        let header = settingsViewModel.getHeaderViewModel(for: section)
        titleLabel.text = header.title
    }
}
