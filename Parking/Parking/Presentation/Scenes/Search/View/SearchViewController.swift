//
//  SearchViewController.swift
//  Parking
//
//  Created by Maxim Terpugov on 17.08.2022.
//

import UIKit


final class SearchViewController: UIViewController,
                                  UITableViewDelegate,
                                  UITableViewDataSource,
                                  UISearchBarDelegate {
    
    // MARK: - Dependencies

    private let viewModel: SearchViewModelProtocol
    
    
    // MARK: - Init
    
    init(viewModel: SearchViewModelProtocol,
         nibName nibNameOrNil: String? = nil,
         bundle nibBundleOrNil: Bundle? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Input data flow

    private func setupObservers() {
        viewModel.parkings.subscribe(observer: self) { [weak self] parkings in
            self?.tableView.reloadSections(IndexSet(integer: 0),
                                           with: .automatic)
        }
    }
    
    
    // MARK: - View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupLayout()
        setupObservers()
        viewModel.viewDidLoad()
    }
    
        
    // MARK: - UI
    
    private func setupNavigationBar() {
        navigationItem.title = "Поиск парковок"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController()
        controller.searchBar.placeholder = "Поиск"
        controller.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.barStyle = .default
        controller.searchBar.isTranslucent = false
        controller.searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9568627451, alpha: 1)
        controller.searchBar.searchTextField.tintColor = #colorLiteral(red: 0.5112195015, green: 0.5112671256, blue: 0.5304653645, alpha: 1)
        controller.searchBar.searchTextField.leftView?.tintColor = #colorLiteral(red: 0.5112195015, green: 0.5112671256, blue: 0.5304653645, alpha: 1)
        controller.searchBar.keyboardAppearance = .light
        controller.searchBar.delegate = self
        return controller
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self,
                       forCellReuseIdentifier: SearchTableViewCell.identifier)
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    // MARK: - Layout

    private func setupLayout() {
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    // MARK: - Table View

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.parkings.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            fatalError()
        }
        let adress = viewModel.parkings.value[indexPath.row].adress
        let cost = viewModel.parkings.value[indexPath.row].hourCost
        cell.setAdress(adress)
        cell.setCost(cost)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentingViewController?.dismiss(animated: true, completion: {
            self.viewModel.didSelectRow(at: indexPath.row)
        })
    }
    
    
    // MARK: - SearchBar

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchBarTextDidChange(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchBarCancelButtonClicked()
    }
    
}
