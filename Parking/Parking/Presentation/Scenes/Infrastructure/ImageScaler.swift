//
//  ImageScaler.swift
//  Parking
//
//  Created by Maxim Terpugov on 28.07.2022.
//

import UIKit


extension UIImage {
    func scale(toSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(toSize, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: toSize))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return newImage
    }
}
