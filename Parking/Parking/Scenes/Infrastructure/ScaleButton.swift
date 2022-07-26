//
//  Infrastructure.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.07.2022.
//

import UIKit


class ScaleButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) {
                let scale: CGFloat = 0.97
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: scale, y: scale) : .identity
                self.alpha = self.isHighlighted ? 0.6 : 1
            }
        }
    }
}
