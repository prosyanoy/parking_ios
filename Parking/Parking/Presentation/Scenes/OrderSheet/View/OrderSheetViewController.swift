//
//  OrderSheetViewController.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.07.2022.
//

import UIKit


final class OrderSheetViewController: UIViewController,
                                      UITableViewDelegate,
                                      UITableViewDataSource {
    
    // MARK: - Dependencies
    
    private let transitionDelegate: UIViewControllerTransitioningDelegate
    private let didLayoutHeightCallback: (Float) -> Void
    private let dismissOrderSheetCallback: () -> Void
    
    
    // MARK: - State
    
    private let parking: Parking
    private let routeInformation: [Double]
    
    
    // MARK: - Init
    
    init(transitionDelegate: UIViewControllerTransitioningDelegate,
         parking: Parking,
         routeInformation: [Double],
         didLayoutHeightCallback: @escaping (Float) -> Void,
         dismissOrderSheetCallback: @escaping () -> Void,
         nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?) {
        self.transitionDelegate = transitionDelegate
        self.parking = parking
        self.routeInformation = routeInformation
        self.didLayoutHeightCallback = didLayoutHeightCallback
        self.dismissOrderSheetCallback = dismissOrderSheetCallback
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        setupLayout()
        user.notify()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        didLayoutHeightCallback(Float(view.frame.height))
    }
    
    
    // MARK: - UI
    
    private lazy var tableView: ResizingTableView = {
        let table = ResizingTableView()
        table.register(UsersAutoTableViewCell.self,
                       forCellReuseIdentifier: UsersAutoTableViewCell.identifier)
        table.register(ParkingTableViewCell.self, forCellReuseIdentifier: ParkingTableViewCell.identifier)
        table.register(TimeTableViewCell.self, forCellReuseIdentifier: TimeTableViewCell.identifier)
        table.backgroundColor = .white
        table.estimatedRowHeight = 70
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus"),
                        for: .disabled)
        button.imageView?.layer.transform = CATransform3DMakeScale(2, 2, 0)
        button.tintColor = .systemGray
        button.isEnabled = false
        return button
    }()
    
    private lazy var payButton: UIButton = {
        let button = ScaleButton()
        button.setTitle("Оплатить",
                        for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16,
                                                    weight: .semibold)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0, green: 0.7409000993, blue: 0.9917448163, alpha: 1)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func payButtonTapped() {
        let vc = ParkingPaymentSceneConfigurator.configure(paidParking: parking)
        present(vc, animated: true, completion: nil)
    }
    
    
    // MARK: - Layout
    
    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(dismissButton)
        view.addSubview(payButton)
        
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true // 5
        dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 5).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10).isActive = true
        payButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersAutoTableViewCell.identifier, for: indexPath) as? UsersAutoTableViewCell else {
                fatalError()
            }
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ParkingTableViewCell.identifier, for: indexPath) as? ParkingTableViewCell else {
                fatalError()
            }
            cell.selectionStyle = .none
            cell.setParkingLabel(parking.adress)
            cell.setParkingAdress(parking.adress)
            cell.setParkingCost(String(parking.hourCost))
            cell.setupDependencies(invalidateInternalCellSizeCallback: { [weak self] in
                self?.tableView.beginUpdates()
                self?.tableView.endUpdates()
            })
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TimeTableViewCell.identifier, for: indexPath) as? TimeTableViewCell else {
                fatalError()
            }
            cell.selectionStyle = .none
            cell.setTimeLabel(String("\(Int(routeInformation[0])) мин (\(Int(routeInformation[1])) км)"))
            return cell
        default:
            fatalError()
        }
    }
    
    
    // MARK: - Interface
    
    func collapseCells() {
        tableView.visibleCells.forEach { cell in
            if let parkingCell = cell as? ParkingTableViewCell {
                parkingCell.collapseCell()
            }
        }
    }
    
    
    // MARK: - Deinit
    
    deinit {
        dismissOrderSheetCallback()
    }
}
