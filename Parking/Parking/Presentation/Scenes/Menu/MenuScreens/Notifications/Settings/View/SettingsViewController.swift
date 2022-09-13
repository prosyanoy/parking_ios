//
//  SettingsViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 16.08.2022.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let viewModel: SettingsViewModelProtocol
    private let settingsTableView = SettingsTableView()
    
    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        title = "Настройки"
        setDelegates()
        setupLayout()
    }
    
    private func setDelegates() {
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
    }
    
    private func setupLayout() {
        view.addSubview(settingsTableView)
        
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc func switchChanged(_ sender: UISwitch!) {
        switch sender.tag {
        case 0:
            UserDefaultsDataManager.notify10MinutesBeforeBooking = sender.isOn
        case 1:
            UserDefaultsDataManager.notifyBookingStarts = sender.isOn
        case 2:
            UserDefaultsDataManager.notify10minutesEndingBooking = sender.isOn
        case 3:
            UserDefaultsDataManager.notifyAtTheEndOfParking = sender.isOn
        case 4:
            UserDefaultsDataManager.notifyAwayFromTheParking = sender.isOn
        default:
            print("default")
        }
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCellView.reuseIdentifier, for: indexPath) as? SettingsCellView
        cell?.configure(with: viewModel, for: indexPath)
        cell?.switchHandler.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        cell?.switchHandler.tag = indexPath.row
        if let tag = cell?.switchHandler.tag {
            if tag >= 1 && tag <= 3 {
                cell?.switchHandler.isOn = true
            }
        }
        return cell ?? SettingsCellView()
    }
}
