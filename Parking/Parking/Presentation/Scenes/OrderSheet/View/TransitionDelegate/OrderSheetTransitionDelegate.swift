//
//  OrderSheetTransitionDelegate.swift
//  Parking
//
//  Created by Maxim on 26.07.2022.
//

import UIKit


final class OrderSheetTransitionDelegate: NSObject,
                                     UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return OrderSheetPresentationViewController(presentedViewController: presented,
                                               presenting: presenting ?? source)
    }
    
}
