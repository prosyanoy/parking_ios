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
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1)
        button.setTitle("Сохранить изменения", for: .normal)
        button.titleLabel?.font = .overpassBold17
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
    
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
        saveButton.addTarget(self, action: #selector(saveProfileInfo), for: .touchUpInside)
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
        view.backgroundColor = .white
        title = "Личный кабинет"
    }
    
    private func setupLayout() {
        view.addSubview(profileTableView)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: saveButton.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func deleteProfile() {
        let alert = UIAlertController(title: "Вы уверены что хотите удалить учетную запись? Все данные также будут удалены.",
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { [unowned self] _ in
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
    
    @objc func logOut() {
        let alert = UIAlertController(title: "Вы уверены что хотите выйти из учетной записи?",
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Выйти", style: .default, handler: { [unowned self] _ in
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1).cgColor
        textField.layer.borderWidth = 2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        saveButton.isHidden = false
    }
    
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
        if section == 6 {
            return 0
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section <= 3 && section >= 1 {
            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell: UITableViewCell = UITableViewCell()
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTitleCell.reuseIdentifier, for: indexPath) as? ProfileTitleCell
            cell?.configure(with: viewModel, for: indexPath)
            cell?.logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
            returnCell = cell ?? ProfileTitleCell()
        case 1,2,3:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileNameCell.reuseIdentifier, for: indexPath) as? ProfileNameCell
            cell?.configure(with: viewModel, for: indexPath)
            cell?.profileTextField.delegate = self
            cell?.profileTextField.tag = indexPath.section
            returnCell = cell ?? ProfileNameCell()
        case 4,5:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileEmailPhoneCell.reuseIdentifier, for: indexPath) as? ProfileEmailPhoneCell
            cell?.configure(with: viewModel, for: indexPath)
            cell?.accessoryView?.tintColor = UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1)
            returnCell = cell ?? ProfileEmailPhoneCell()
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileDeleteCell.reuseIdentifier, for: indexPath) as? ProfileDeleteCell
            cell?.configure(with: viewModel, for: indexPath)
            returnCell = cell ?? ProfileDeleteCell()
        default:
            break
        }
        return returnCell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var vc: UIViewController = UIViewController()
        switch indexPath.section {
        case 1,2,3:
            let cell = tableView.cellForRow(at: indexPath) as? ProfileNameCell
            cell?.profileTextField.becomeFirstResponder()
        case 4:
            vc = ChangePhonenumberConfigurator.configure()
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            vc = EnterEmailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 6:
            deleteProfile()
            vc = UserPhoneNumberConfirmationConfigurator.configure()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc, animated: true)
        default:
            break
        }
    }
}
