//
//  TextDrawer.swift
//  Parking
//
//  Created by Maxim Terpugov on 02.08.2022.
//

import UIKit


extension UIView {
    func drawImageWithText(text: String,
                           textAttributes: [NSAttributedString.Key : Any],
                           textFrame: CGRect) -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(self.bounds.size,
                                               false,
                                               scale)
        let textFontAttributes = textAttributes
        guard let contex = UIGraphicsGetCurrentContext() else { return nil }
        self.layer.render(in: contex)
        let rect = textFrame
        text.draw(in: rect,
                  withAttributes: textFontAttributes)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

