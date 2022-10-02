//
//  MenuViewController.swift
//  Parking
//
//  Created by Sofia Lupeko on 01.08.2022.
//

import Foundation
import UIKit

final class MenuViewController: UIViewController {
    private let viewModel: MenuViewModelProtocol
    private let menuTableView: MenuTableView
    
    init(viewModel: MenuViewModelProtocol, menuTableView: MenuTableView) {
        self.viewModel = viewModel
        self.menuTableView = menuTableView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupNavigationController()
        setupLayout()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "Меню"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.setRightBarButton(UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeButtonTapped(_:))),
                                         animated: false)
    }
    
    private func setDelegates() {
        menuTableView.dataSource = self
        menuTableView.delegate = self
    }
    
    private func setupLayout() {
        view.addSubview(menuTableView)
        
        NSLayoutConstraint.activate([
            menuTableView.topAnchor.constraint(equalTo: view.topAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc private func closeButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension MenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell: UITableViewCell = UITableViewCell()
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuTitleCellView.reuseIdentifier, for: indexPath) as? MenuTitleCellView
            cell?.configure(with: viewModel, for: indexPath)
            cell?.accessoryView?.tintColor = UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1)
            returnCell = cell ?? MenuTitleCellView()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuCellView.reuseIdentifier, for: indexPath) as? MenuCellView
            cell?.configure(with: viewModel, for: indexPath)
            returnCell = cell ?? MenuCellView()
        }
        return returnCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuHeaderView.reuseIdentifier) as? MenuHeaderView
        header?.configure(with: viewModel, for: section)
        return header ?? MenuHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return tableView.sectionHeaderHeight
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = viewModel.getCellViewModel(for: indexPath)
        viewModel.menuCellTapped(with: selectedCell)
        // пуш контроллера навигейшеном тут или в роутере
        var vc: UIViewController = UIViewController()
        switch indexPath.section {
        case 0:
            vc = ProfileConfigurator.configure()
        case 1:
            switch indexPath.row {
            case 0:
                vc = MyParkingsViewController()
            case 1:
                vc = NotificationsViewController()
            case 2:
                vc = NewsViewController()
            case 3:
                vc = CarsViewController()
            default:
                print("default")
            }
        case 2:
            switch indexPath.row {
            case 0:
                if let paymentNC = WalletPaymentSceneConfigurator.configure() as? UINavigationController {
                    if let paymentVC = paymentNC.viewControllers.first as? WalletPaymentViewController {
                        paymentVC.isPushed = true
                        vc = paymentVC
                    }
                }
            case 1:
                vc = FinesAndEvacuationsViewController()
            default:
                print("default")
            }
        case 3:
            switch indexPath.row {
            case 0:
                vc = ChangeCityViewController()
            case 1:
                vc = FreeParkingViewController()
            case 2:
                vc = FeedbackViewController()
            case 3:
                vc = AboutConfigurator.configure()
            default:
                print("default")
            }
        default:
            print("default")
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
}
