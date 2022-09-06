//
//  MapFiltersViewController.swift
//  Parking
//
//  Created by Maxim Terpugov on 30.08.2022.
//

import UIKit


final class MapFiltersViewController: UIViewController,
                                      UITableViewDelegate,
                                      UITableViewDataSource {
    
    // MARK: - Dependencies

    private let viewModel: MapFiltersViewModelProtocol
    
    
    // MARK: - Init

    init(viewModel: MapFiltersViewModelProtocol,
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.layoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.layoutSubviews()
    }
    
    
    // MARK: - UI
    
    private func setupInitialUI() {
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Фильтры"
        navigationItem.setLeftBarButton(
            UIBarButtonItem(title: "Отмена",
                            style: .plain,
                            target: self,
                            action: #selector(cancelButtonTapped)),
            animated: false)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true,
                completion: nil)
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(MapFiltersTableViewHeader.self, forHeaderFooterViewReuseIdentifier: MapFiltersTableViewHeader.identifier)
        table.register(PriceMapFilterTableViewCell.self,
                       forCellReuseIdentifier: PriceMapFilterTableViewCell.identifier)
        table.register(ServicesMapFilterTableViewCell.self,
                       forCellReuseIdentifier: ServicesMapFilterTableViewCell.identifier)
        table.register(TypeMapFilterTableViewCell.self,
                       forCellReuseIdentifier: TypeMapFilterTableViewCell.identifier)
        table.backgroundColor = .white
        table.estimatedRowHeight = 70
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var applyButton: UIButton = {
        let button = ScaleButton()
        button.setTitle("Применить",
                        for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16,
                                                    weight: .semibold)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.6046196818, green: 0.4869016409, blue: 0.8574097753, alpha: 1)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func applyButtonTapped() {
        viewModel.applyButtonTapped()
        presentingViewController?.dismiss(animated: true, completion: {
            
        })
    }
    
    
    // MARK: - Table View

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MapFiltersTableViewHeader.identifier) as? MapFiltersTableViewHeader else {
                fatalError()
            }
            header.setContent(title: "Тип парковки")
            return header
        case 1:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MapFiltersTableViewHeader.identifier) as? MapFiltersTableViewHeader else {
                fatalError()
            }
            header.setContent(title: "Дополнительно")
            return header
        case 2:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MapFiltersTableViewHeader.identifier) as? MapFiltersTableViewHeader else {
                fatalError()
            }
            header.setContent(title: "Стоимость")
            return header
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TypeMapFilterTableViewCell.identifier, for: indexPath) as? TypeMapFilterTableViewCell else {
                fatalError()
            }
            cell.selectionStyle = .none
            cell.setupDependencies(viewModel: viewModel)
            let isCovered = viewModel.filterParameters.covered
            let isFree = viewModel.filterParameters.free
            cell.setContent(isCovered: isCovered, isFree: isFree)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ServicesMapFilterTableViewCell.identifier, for: indexPath) as? ServicesMapFilterTableViewCell else {
                fatalError()
            }
            cell.selectionStyle = .none
            cell.setupDependencies(viewModel: viewModel)
            cell.setContent(secureValue: viewModel.filterParameters.secure,
                            aroundTheClockValue: viewModel.filterParameters.arountTheClock,
                            evChargingValue: viewModel.filterParameters.evCharging,
                            disabledValue: viewModel.filterParameters.disabledPersons)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PriceMapFilterTableViewCell.identifier, for: indexPath) as? PriceMapFilterTableViewCell else {
                fatalError()
            }
            cell.selectionStyle = .none
            cell.setupDependencies(viewModel: viewModel)
            let price = viewModel.filterParameters.price
            cell.setContent(priceValue: price)
            return cell
        default:
            fatalError()
        }
    }
    
    
    // MARK: - Layout
    
    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(applyButton)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        applyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        applyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    
}
