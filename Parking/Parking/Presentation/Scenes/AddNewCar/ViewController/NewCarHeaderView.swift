//
//  NewCarHeaderVC.swift
//  Parking
//
//  Created by mac on 08.09.2022.
//

import UIKit

final class NewCarHeaderView: UITableViewHeaderFooterView {
    static var reuseIdentifier: String { "\(Self.self)" }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
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
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

extension NewCarHeaderView {
    func configure(with newCarViewModel: NewCarViewModelProtocol, for section: Int) {
        let header = newCarViewModel.getHeaderViewModel(for: section)
        titleLabel.text = header.title
    }
}
