//
//  OwnersOnParkingViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 26.08.2022.
//

import Foundation
import UIKit

final class OwnersOnParkingViewController: UIViewController {
    
    private let viewModel: OwnersOnParkingViewModelProtocol
    private let onParkingTableView = OwnersOnParkingTableView(frame: CGRect.zero, style: .insetGrouped)
    
    init(viewModel: OwnersOnParkingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "На стоянке"
        setupLayout()
        setDelegates()
    }
    
    private func setDelegates() {
        onParkingTableView.dataSource = self
        onParkingTableView.delegate = self
    }
    
    private func setupLayout() {
        view.addSubview(onParkingTableView)

        NSLayoutConstraint.activate([
            onParkingTableView.topAnchor.constraint(equalTo: view.topAnchor),
            onParkingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            onParkingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onParkingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension OwnersOnParkingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: OwnersOnParkingCellView.reuseIdentifier, for: indexPath) as? OwnersOnParkingCellView
        
        cell?.configure(with: viewModel, for: indexPath)
        cell?.layer.masksToBounds = true
        cell?.layer.borderWidth = 2
        cell?.layer.cornerRadius = 15
        cell?.layer.borderColor = UIColor.darkGray.cgColor
        
        return cell ?? OwnersOnParkingCellView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
