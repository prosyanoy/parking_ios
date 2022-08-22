//
//  ParkingSearchBottomSheet.swift
//  Parking
//
//  Created by Maxim Terpugov on 19.08.2022.
//

import UIKit


final class ParkingSearchBottomSheet: UIViewController,
                                      UITableViewDelegate,
                                      UITableViewDataSource {
    
    // MARK: - Dependencies

    private let viewModel: ParkingSearchBottomSheetViewModelProtocol
    private let transitionDelegate: UIViewControllerTransitioningDelegate
    private let didLayoutHeightCallback: (Float) -> Void
    private let dismissOrderSheetCallback: () -> Void
    
    
    // MARK: - Init

    init(viewModel: ParkingSearchBottomSheetViewModelProtocol,
        transitionDelegate: UIViewControllerTransitioningDelegate,
         didLayoutHeightCallback: @escaping (Float) -> Void,
         dismissOrderSheetCallback: @escaping () -> Void,
         nibName nibNameOrNil: String? = nil,
         bundle nibBundleOrNil: Bundle? = nil) {
        self.viewModel = viewModel
        self.transitionDelegate = transitionDelegate
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
        table.register(ParkingSearchTableViewCell.self, forCellReuseIdentifier: ParkingSearchTableViewCell.identifier)
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
    
    
        // MARK: - Layout
    
    private func setupLayout() {
        view.addSubview(dismissButton)
        view.addSubview(tableView)

        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 15).isActive = true

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 5).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ParkingSearchTableViewCell.identifier, for: indexPath) as? ParkingSearchTableViewCell else {
                fatalError()
            }
            cell.setupDependencies(viewModel: viewModel)
            cell.selectionStyle = .none
            return cell
        default:
            fatalError()
        }
    }
    
    
    // MARK: - Deinit
    
    deinit {
        dismissOrderSheetCallback()
    }
    
}
