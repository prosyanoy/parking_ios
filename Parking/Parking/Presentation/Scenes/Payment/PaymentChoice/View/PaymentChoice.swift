//
//  PaymentChoice.swift
//  Parking
//
//  Created by Maxim Terpugov on 23.08.2022.
//

import UIKit


final class PaymentChoiceViewController: UIViewController,
                                         UITableViewDelegate,
                                         UITableViewDataSource {
    
    // MARK: - Dependencies
    
    private let viewModel: PaymentChoiceViewModelProtocol
    
    
    // MARK: - Init
    
    init(viewModel: PaymentChoiceViewModelProtocol,
         nibName nibNameOrNil: String? = nil,
         bundle nibBundleOrNil: Bundle? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialUI()
        setupNavigationBar()
        setupLayout()
    }
    
    
    // MARK: - UI
    
    private func setupInitialUI() {
        view.backgroundColor = #colorLiteral(red: 0.820894897, green: 0.8209463358, blue: 0.8418663144, alpha: 1)
    }
    
    private func setupNavigationBar() {
        navigationItem.backButtonTitle = "Пополнить счет"
    }
    
    private lazy var tableView: ResizingTableView = {
        let table = ResizingTableView()
        table.register(PaymentChoiceTableViewCell.self, forCellReuseIdentifier: PaymentChoiceTableViewCell.identifier)
        table.backgroundColor = #colorLiteral(red: 0.820894897, green: 0.8209463358, blue: 0.8418663144, alpha: 1)
        table.rowHeight = 100
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var addCardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Привязать банковскую карту", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(addCardButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func addCardButtonTapped() {
        viewModel.addCardButtonTapped()
    }
    
    
    // MARK: - Layout
    
    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(addCardButton)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        addCardButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 5).isActive = true
        addCardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PaymentChoiceTableViewCell.identifier, for: indexPath) as? PaymentChoiceTableViewCell else { fatalError() }
        let content = viewModel.paymentMethods[indexPath.row]
        cell.setContent(title: content.title, description: content.description, icon: nil)
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(index: indexPath.row)
    }
    
}

