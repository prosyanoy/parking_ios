//
// OwnersEntryViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 26.08.2022.
//

import Foundation
import UIKit

final class OwnersEntryViewController: UIViewController {
    
    private let viewModel: OwnersEntryViewModelProtocol
    private let entryTableView = OwnersEntryTableView(frame: CGRect.zero, style: .insetGrouped)
    
    init(viewModel: OwnersEntryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Въезд"
        setupLayout()
        setDelegates()
    }
    
    private func setDelegates() {
        entryTableView.dataSource = self
        entryTableView.delegate = self
    }
    
    private func setupLayout() {
        view.addSubview(entryTableView)
        
        NSLayoutConstraint.activate([
            entryTableView.topAnchor.constraint(equalTo: view.topAnchor),
            entryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            entryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            entryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension OwnersEntryViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: OwnersEntryCellView.reuseIdentifier, for: indexPath) as? OwnersEntryCellView
        
        cell?.configure(with: viewModel, for: indexPath)
        cell?.layer.masksToBounds = true
        cell?.layer.borderWidth = 2
        cell?.layer.cornerRadius = 15
        cell?.layer.borderColor = UIColor.darkGray.cgColor
        
        return cell ?? OwnersEntryCellView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
