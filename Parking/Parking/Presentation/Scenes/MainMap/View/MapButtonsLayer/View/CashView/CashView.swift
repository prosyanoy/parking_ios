//
//  CashView.swift
//  Parking
//
//  Created by Sofia Lupeko on 28.07.2022.
//

import Foundation
import UIKit

final class CashView: UIControl {
	private let cashLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.contentMode = .center
		label.textAlignment = .center
		label.text = "0 Р"
		return label
	}()

	private let divider: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .darkGray
		return view
	}()

	private let plusView: UIImageView = {
		let view = UIImageView(image: UIImage(named: "Plus"))
		view.contentMode = .scaleAspectFit
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	init() {
		super.init(frame: .zero)
		setupLayout()
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override var isHighlighted: Bool {
		didSet {
			backgroundColor = isHighlighted ? .lightGray : .white
		}
	}

	private func setupLayout() {
		addSubview(cashLabel)
		addSubview(divider)
		addSubview(plusView)

		NSLayoutConstraint.activate([
			cashLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			cashLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			cashLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

			divider.topAnchor.constraint(equalTo: cashLabel.topAnchor),
			divider.bottomAnchor.constraint(equalTo: cashLabel.bottomAnchor),
			divider.leadingAnchor.constraint(equalTo: cashLabel.trailingAnchor, constant: 16),
			divider.widthAnchor.constraint(equalToConstant: 1),

			plusView.leadingAnchor.constraint(equalTo: divider.trailingAnchor, constant: 16),
			plusView.topAnchor.constraint(equalTo: cashLabel.topAnchor),
			plusView.bottomAnchor.constraint(equalTo: cashLabel.bottomAnchor),
			plusView.widthAnchor.constraint(equalTo: plusView.heightAnchor),
			plusView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
		])
	}

	private func setupUI() {
		backgroundColor = .white
		tintColor = .systemBlue
		backgroundColor = .white
		layer.cornerRadius = 20
		layer.shadowRadius = 5
		layer.shadowOffset = CGSize(width: 4, height: 4)
		layer.shadowOpacity = 0.2
		layer.shadowColor = UIColor.black.cgColor
	}
}
