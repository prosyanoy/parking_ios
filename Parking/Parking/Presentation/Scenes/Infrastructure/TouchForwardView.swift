//
//  TouchForwardView.swift
//  Parking
//
//  Created by Maxim Terpugov on 11.08.2022.
//

import UIKit


class TouchForwardView: UIView {
    
    var touchForwardTargetViews = [UIView]()
    var touchForwardingEnabled = true
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitTestView = super.hitTest(point, with: event)
        if hitTestView == self && touchForwardingEnabled {
            for targetView in touchForwardTargetViews {
                let convertedPoint = convert(point, to: targetView)
                if let hitTargetView = targetView.hitTest(convertedPoint, with: event) {
                    return hitTargetView
                }
            }
        }
        return hitTestView
    }
}
