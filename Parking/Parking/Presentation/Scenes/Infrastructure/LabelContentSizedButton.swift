//
//  LabelContentSizedButton.swift
//  Parking
//
//  Created by Maxim Terpugov on 09.08.2022.
//

import UIKit


class LabelContentSizedButton: UIButton {
    override var intrinsicContentSize: CGSize {
        return titleLabel?.intrinsicContentSize ?? super.intrinsicContentSize
    }
}
