//
//  NotificationsViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 16.08.2022.
//

import UIKit

final class NotificationsViewController: UIViewController {
    
    override func viewDidLoad() {
        super .viewDidLoad()
        view.backgroundColor = .white
        title = "Уведомления"
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                                         style: .plain,
                                                         target: self,
                                                         action: #selector(pushSettingsVC)),
                                         animated: true)
    }
    
    @objc func pushSettingsVC() {
        let settingsVC = SettingsConfigurator.configure()
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
}
