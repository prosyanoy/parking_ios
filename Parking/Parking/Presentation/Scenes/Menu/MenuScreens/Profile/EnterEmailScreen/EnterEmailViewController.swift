//
//  EnterEmailViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 10.09.2022.
//

import Foundation
import UIKit

final class EnterEmailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var email: String = ""
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.register(EnterEmailCellView.self, forCellReuseIdentifier: EnterEmailCellView.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setDelegates()
        setupLayout()
    }
    
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureUI() {
        title = "E-mail"
        view.backgroundColor = .white
        navigationItem.setRightBarButton(
            UIBarButtonItem(title: "Готово",
                            style: .plain,
                            target: self,
                            action: #selector(saveEmail)),
            animated: false)
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
    }
    
    @objc func saveEmail() {
        guard let vcCount = self.navigationController?.viewControllers.count  else {return}
        let backVC = self.navigationController?.viewControllers[vcCount - 2] as! ProfileViewController
        backVC.viewModel.profileInfo.email = email
        backVC.profileTableView.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            email = text
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EnterEmailCellView.reuseIdentifier) as? EnterEmailCellView
        cell?.emailTextField.delegate = self
        return cell ?? EnterEmailCellView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as? EnterEmailCellView
        cell?.emailTextField.becomeFirstResponder()
    }
    
    //MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string == "\n") {
            textField.resignFirstResponder()
        }
        return true
    }
}
