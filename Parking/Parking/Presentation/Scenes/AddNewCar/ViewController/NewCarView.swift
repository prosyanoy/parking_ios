//
//  NewCarVC.swift
//  Parking
//
//  Created by mac on 08.09.2022.
//

import Foundation
import UIKit

class NewCarNumberViewController: UIViewController {
    let viewModel: NewCarViewModelProtocol
    var newCarTableView = NewCarTableView()
    let defaults = UserDefaults.standard

    init(viewModel: NewCarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setupLayuot()
        setTarget()
//        newCarTableView = UITableView.init(frame: view.bounds, style: .insetGrouped)
//        newCarTableView.register(NumberCarCell.self, forCellReuseIdentifier: NumberCarCell.identifier)
//        newCarTableView.register(NameCarCell.self, forCellReuseIdentifier: NameCarCell.identifier)
//        newCarTableView.register(StsCell.self, forCellReuseIdentifier: StsCell.identifier)
//        newCarTableView.register(TypeCarCell.self, forCellReuseIdentifier: TypeCarCell.identifier)
//        newCarTableView.register(SpecialNumberCell.self, forCellReuseIdentifier: SpecialNumberCell.identifier)
//        newCarTableView.register(ForeignNumberCell.self, forCellReuseIdentifier: ForeignNumberCell.identifier)
    }
    
    private func setDelegate() {
        newCarTableView.delegate = self
        newCarTableView.dataSource = self
    }
    
    private func setupLayuot() {
        newCarTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newCarTableView)
        view.addSubview(addNewCarButton)
        newCarTableView.addSubview(addNewCarButton)
        NSLayoutConstraint.activate([
            newCarTableView.topAnchor.constraint(equalTo: view.topAnchor),
            newCarTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newCarTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newCarTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addNewCarButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 38),
            addNewCarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    let addNewCarButton: UIButton = {
        let button = UIButton()
        let buttonColorOn = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(buttonColorOn, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    func setTarget() {
        addNewCarButton.addTarget(self, action: #selector(addNewCar(_:)), for: .touchUpInside)
    }
    
    @objc func addNewCar(_ sender: UIButton) {
       dismiss(animated: true)
    }
}

extension NewCarNumberViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let typeCarCell = tableView.dequeueReusableCell(withIdentifier:
            TypeCarCell.reuseIdentifier, for: indexPath)
                as? TypeCarCell else {
            return
        }
        defaults.set(typeCarCell.name[indexPath.row], forKey: "typeOfCar")
        tableView.reloadData()
        
        if defaults.string(forKey: "numberOfCar") != nil {
            addNewCarButton.isHidden = false
        } else {
            addNewCarButton.isHidden = true
        }
        
    }
}

extension NewCarNumberViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.getCellViewModel(for: indexPath, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewCarHeaderView.reuseIdentifier) as? NewCarHeaderView
        header?.configure(with: viewModel, for: section)
        return header ?? NewCarHeaderView()
    }

    
}

//extension NewCarNumberViewController {
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        guard let header = view as? UITableViewHeaderFooterView else { return }
//
//        switch section {
//        case 0:
//
//            header.textLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 15)
//            header.textLabel?.textColor = .darkGray
//            header.textLabel?.textAlignment = .center
//        case 1:
//            header.textLabel?.textColor = .darkGray
//            header.textLabel?.textAlignment = .left
//        case 2:
//
//            header.textLabel?.textColor = .darkGray
//            header.textLabel?.textAlignment = .center
//        default:
//            break
//        }
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 0:
//            return ""
//        case 1:
//            return "ТИП АВТОМОБИЛЯ"
//        case 2:
//            return ""
//        default:
//            return nil
//        }
//    }
//
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        switch section {
//        case 0:
//            return ""
//        case 1:
//            return ""
//        case 2:
//            return "Укажите серию и номер свидетельства о регистрации ТС и узнавайте о штрафах"
//        default:
//            return nil
//        }
//    }
//}
