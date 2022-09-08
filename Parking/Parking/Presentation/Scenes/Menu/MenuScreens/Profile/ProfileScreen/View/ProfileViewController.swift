//
//  ProfileViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 16.08.2022.
//

import UIKit

final class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel: ProfileViewModelProtocol
    let profileTableView = ProfileTableView(frame: CGRect.zero, style: .insetGrouped)
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        fetchProfileInfo()
        configureUI()
        setDelegates()
        setupLayout()
    }
    
    private func fetchProfileInfo() {
        ProfileNetworkManager.shared.fetchProfileInfo { [unowned self] profileInfo in
            self.viewModel.profileInfo = profileInfo
        }
    }
    
    private func setDelegates() {
        profileTableView.dataSource = self
        profileTableView.delegate = self
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        title = "Личный кабинет"
        navigationItem.setRightBarButton(
            UIBarButtonItem(title: "Готово",
                            style: .plain,
                            target: self,
                            action: #selector(saveProfileInfo)),
            animated: false)
    }
    
    private func setupLayout() {
        view.addSubview(profileTableView)
        
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func deleteProfile(title: String) {
        let alert = UIAlertController(title: "Вы уверены что хотите \(title.lowercased())? Вся информация об оплатах и добавленных машинах будет утеряна",
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { [unowned self] _ in
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            UserDefaultsDataManager.userIsRegistered = false
            UserDefaultsDataManager.userIsLogedIn = false
            let vc = UserPhoneNumberConfirmationConfigurator.configure()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func logOut(title: String) {
        let alert = UIAlertController(title: "Вы уверены что хотите \(title.lowercased())?",
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { [unowned self] _ in
            print("Log out")
            UserDefaultsDataManager.userIsLogedIn = false
            let vc = UserPhoneNumberConfirmationConfigurator.configure()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc func saveProfileInfo() {
        ProfileNetworkManager.shared.saveNewProfileInfo(profileInfo: viewModel.profileInfo)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    //MARK: - UITextFieldDelegate
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            viewModel.profileInfo.surname = textField.text
        case 1:
            viewModel.profileInfo.name = textField.text
        case 2:
            viewModel.profileInfo.patronymic = textField.text
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string == "\n") {
            textField.resignFirstResponder()
        }
        return true
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInSection(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.reuseIdentifier) as? ProfileHeaderView
        header?.configure(with: viewModel, for: section)
        return header ?? ProfileHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 {
            return 60
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section <= 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileNameCell.reuseIdentifier, for: indexPath) as? ProfileNameCell
            cell?.configure(with: viewModel, for: indexPath)
            cell?.profileTextField.delegate = self
            cell?.profileTextField.tag = indexPath.section
            return cell ?? ProfileNameCell()
        } else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileDeleteLogoutCell.reuseIdentifier, for: indexPath) as? ProfileDeleteLogoutCell
            cell?.configure(with: viewModel, for: indexPath)
            return cell ?? ProfileDeleteLogoutCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileEmailPhoneCell.reuseIdentifier, for: indexPath) as? ProfileEmailPhoneCell
            cell?.configure(with: viewModel, for: indexPath)
            return cell ?? ProfileEmailPhoneCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var vc: UIViewController = UIViewController()
        switch indexPath.section {
        case 0:
            let cell = tableView.cellForRow(at: indexPath) as? ProfileNameCell
            cell?.profileTextField.becomeFirstResponder()
        case 1:
            let cell = tableView.cellForRow(at: indexPath) as? ProfileNameCell
            cell?.profileTextField.becomeFirstResponder()
        case 2:
            let cell = tableView.cellForRow(at: indexPath) as? ProfileNameCell
            cell?.profileTextField.becomeFirstResponder()
        case 3:
            vc = UserPhoneNumberConfirmationConfigurator.configure()
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            vc = EnterEmailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            switch indexPath.row {
            case 0:
                let cell = tableView.cellForRow(at: indexPath) as? ProfileDeleteLogoutCell
                let cellTitle = cell?.titleLabel.text
                deleteProfile(title: cellTitle ?? "")
                vc = UserPhoneNumberConfirmationConfigurator.configure()
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.present(vc, animated: true)
            case 1:
                let cell = tableView.cellForRow(at: indexPath) as? ProfileDeleteLogoutCell
                let cellTitle = cell?.titleLabel.text
                logOut(title: cellTitle ?? "")
            default:
                break
            }
        default:
            break
        }
    }
}
