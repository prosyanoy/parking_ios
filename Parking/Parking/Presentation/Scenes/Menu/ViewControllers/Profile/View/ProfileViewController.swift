//
//  ProfileViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 16.08.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let viewModel: ProfileViewModelProtocol
    private let tableView: ProfileTableView
    
    init(viewModel: ProfileViewModelProtocol, tableView: ProfileTableView) {
        self.viewModel = viewModel
        self.tableView = tableView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        title = "Личный кабинет"
    }
    
}
