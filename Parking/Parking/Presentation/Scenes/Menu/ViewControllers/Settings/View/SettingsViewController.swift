//
//  SettingsViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 16.08.2022.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let viewModel: SettingsViewModelProtocol
    private let settingsTableView: SettingsTableView
    
    init(viewModel: SettingsViewModelProtocol, settingsTableView: SettingsTableView) {
        self.viewModel = viewModel
        self.settingsTableView = settingsTableView
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
            print(sender.isOn ? "Ячейка \(sender.tag + 1) ВКЛ" : "Ячейка \(sender.tag + 1) ВЫКЛ")
        case 1:
            print(sender.isOn ? "Ячейка \(sender.tag + 1) ВКЛ" : "Ячейка \(sender.tag + 1) ВЫКЛ")
        case 2:
            print(sender.isOn ? "Ячейка \(sender.tag + 1) ВКЛ" : "Ячейка \(sender.tag + 1) ВЫКЛ")
        case 3:
            print(sender.isOn ? "Ячейка \(sender.tag + 1) ВКЛ" : "Ячейка \(sender.tag + 1) ВЫКЛ")
        case 4:
            print(sender.isOn ? "Ячейка \(sender.tag + 1) ВКЛ" : "Ячейка \(sender.tag + 1) ВЫКЛ")
        case 5:
            print(sender.isOn ? "Ячейка \(sender.tag + 1) ВКЛ" : "Ячейка \(sender.tag + 1) ВЫКЛ")
        default:
            print("default")
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingsHeaderView.reuseIdentifier) as? SettingsHeaderView
        header?.configure(with: viewModel, for: section)
        return header ?? SettingsHeaderView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCellView.reuseIdentifier, for: indexPath) as? SettingsCellView
        cell?.configure(with: viewModel, for: indexPath)
        cell?.switchHandler.tag = indexPath.row
        cell?.switchHandler.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        return cell ?? SettingsCellView()
    }
}

extension SettingsViewController: UITableViewDelegate {
    
}
