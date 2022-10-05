//
//  EnterEmailViewController.swift
//  Parking
//
//  Created by Анатолий Силиверстов on 10.09.2022.
//

import Foundation
import UIKit

final class EnterEmailViewController: UIViewController, UITextFieldDelegate {
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let leftLabel = UILabel()
        leftLabel.text = "  E-Mail: "
        leftLabel.textColor = .black
        leftLabel.font = .overpassMedium17
        textField.leftView = leftLabel
        textField.leftViewMode = .always
        textField.textAlignment = .left
        textField.font = .overpassMedium17
        textField.isUserInteractionEnabled = true
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
        emailTextField.delegate = self
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
        view.addSubview(emailTextField)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    @objc func saveEmail() {
        guard let vcCount = self.navigationController?.viewControllers.count  else {return}
        let backVC = self.navigationController?.viewControllers[vcCount - 2] as! ProfileViewController
        if let text = emailTextField.text {
            backVC.viewModel.profileInfo.email = text
            backVC.profileTableView.reloadData()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1).cgColor
        textField.layer.borderWidth = 2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string == "\n") {
            textField.resignFirstResponder()
        }
        return true
    }
}
