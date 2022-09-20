//
//  ContentViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 01.09.2022.
//

import Foundation
import UIKit

final class ContentViewController: UIViewController {
    func addAndPresent(_ child: UIViewController,
                       presentedController: UIViewController?) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        if let presentedController = presentedController {
            presentedController.modalPresentationStyle = .fullScreen
            child.present(presentedController, animated: false)
        }
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeChildren() {
        if let _ = presentedViewController {
            self.presentedViewController?.dismiss(animated: false)
        }
        for child in children {
            child.remove()
        }
    }
}

extension UIViewController {
    
    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
