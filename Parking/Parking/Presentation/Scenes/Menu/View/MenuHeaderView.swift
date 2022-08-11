//
//  MenuHeaderView.swift
//  Parking
//
//  Created by Sofia Lupeko on 06.08.2022.
//

import UIKit

final class MenuHeaderView: UITableViewHeaderFooterView {
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
		contentView.backgroundColor = .white

		addSubview(titleLabel)

		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
		])
	}
}

extension MenuHeaderView {
	func configure(with menuViewModel: MenuViewModelProtocol, for section: Int) {
		let header = menuViewModel.getHeaderViewModel(for: section)
		titleLabel.text = header.title
	}
}
