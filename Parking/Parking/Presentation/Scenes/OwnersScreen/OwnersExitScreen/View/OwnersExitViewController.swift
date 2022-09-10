//
//  OwnersExitViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 26.08.2022.
//

import Foundation
import UIKit

final class OwnersExitViewController: UIViewController {
    
    private let viewModel: OwnersExitViewModelProtocol
    private let exitTableView = OwnersExitTableView(frame: CGRect.zero, style: .insetGrouped)
    
    init(viewModel: OwnersExitViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Выезд"
        setDelegates()
        setupLayout()
    }
    
    private func setDelegates() {
        exitTableView.dataSource = self
        exitTableView.delegate = self
    }
    
    private func setupLayout() {
        view.addSubview(exitTableView)
        
        NSLayoutConstraint.activate([
            exitTableView.topAnchor.constraint(equalTo: view.topAnchor),
            exitTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            exitTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            exitTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc func confirmParking(_ sender: UIButton) {
        print("parking confirmed")
    }
    
    @objc func cancelParking(_ sender: UIButton) {
        print("parking canceled")
    }
}

extension OwnersExitViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: OwnersExitCellView.reuseIdentifier, for: indexPath) as? OwnersExitCellView
        
        cell?.configure(with: viewModel, for: indexPath)
        cell?.layer.masksToBounds = true
        cell?.layer.borderWidth = 2
        cell?.layer.cornerRadius = 15
        cell?.layer.borderColor = UIColor.darkGray.cgColor
        cell?.confirmButton.addTarget(self, action: #selector(confirmParking(_:)), for: .touchUpInside)
        cell?.cancelButton.addTarget(self, action: #selector(cancelParking(_:)), for: .touchUpInside)
        cell?.userRatingView.didTouchCosmos = {rating in
            print("Для пользователя \(String(describing: cell?.carNumberLabel.text)) выбран рейтинг \(rating)")
        }
        
        return cell ?? OwnersExitCellView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
