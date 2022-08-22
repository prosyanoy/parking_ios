//
//  ParkingSearchBottomSheetTransitionDelegate.swift
//  Parking
//
//  Created by Maxim Terpugov on 19.08.2022.
//

import UIKit


final class ParkingSearchBottomSheetTransitionDelegate: NSObject,
                                                        UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ParkingSearchBottomSheetPresentationViewController(presentedViewController: presented,
                                                                  presenting: presenting ?? source)
    }
    
}
