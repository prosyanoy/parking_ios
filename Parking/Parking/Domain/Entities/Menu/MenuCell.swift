//
//  MenuCell.swift
//  Parking
//
//  Created by Sofia Lupeko on 01.08.2022.
//

import Foundation

struct MenuCell {
	let iconName: String
	let title: String
	let rightText: String

	init(iconName: String, title: String, rightText: String) {
		self.iconName = iconName
		self.title = title
		self.rightText = rightText
	}
}
