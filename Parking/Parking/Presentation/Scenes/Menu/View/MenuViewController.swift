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
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCellView.reuseIdentifier, for: indexPath) as? MenuCellView
        cell?.configure(with: viewModel, for: indexPath)
        return cell ?? MenuCellView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuHeaderView.reuseIdentifier) as? MenuHeaderView
        header?.configure(with: viewModel, for: section)
        return header ?? MenuHeaderView()
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
            switch indexPath.row {
            case 0:
                vc = ProfileViewController()
            case 1:
                vc = ChangeCityViewController()
            case 2:
                vc = SettingsConfigurator.configure()
            case 3:
                vc = NotificationsViewController()
            case 4:
                vc = NewsViewController()
            case 5:
                vc = HistoryViewController()
            default:
                print("default")
            }
        case 1:
            switch indexPath.row {
            case 0:
                if let paymentNC = PaymentSceneConfigurator.configure() as? UINavigationController {
                    if let paymentVC = paymentNC.viewControllers.first as? PaymentViewController {
                        paymentVC.isPushed = true
                        vc = paymentVC
                    }
                }
            case 1:
                vc = AnalyticsViewController()
            case 2:
                vc = CardsViewController()
            default:
                print("default")
            }
        case 2:
            switch indexPath.row {
            case 0:
                vc = CarsViewController()
            case 1:
                vc = FinesAndEvacuationsViewController()
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
