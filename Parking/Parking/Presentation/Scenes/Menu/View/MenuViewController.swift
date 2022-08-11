//
//  MenuViewController.swift
//  Parking
//
//  Created by Sofia Lupeko on 01.08.2022.
//

import Foundation
import UIKit

final class MenuViewController: UIViewController {
	private let viewModel: MenuViewModelProtocol
	private let menuTableView: MenuTableView

	init(viewModel: MenuViewModelProtocol, menuTableView: MenuTableView) {
		self.viewModel = viewModel
		self.menuTableView = menuTableView
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setDelegates()
		setupNavigationController()
		setupLayout()
	}

	private func setupNavigationController() {
		navigationItem.title = "Меню"
		navigationItem.largeTitleDisplayMode = .always
		navigationItem.setRightBarButton(UIBarButtonItem(
			barButtonSystemItem: .close,
			target: self,
			action: #selector(closeButtonTapped(_:))),
										 animated: false)
	}

	private func setDelegates() {
		menuTableView.dataSource = self
		menuTableView.delegate = self
	}

	private func setupLayout() {
		view.addSubview(menuTableView)

		NSLayoutConstraint.activate([
			menuTableView.topAnchor.constraint(equalTo: view.topAnchor),
			menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
	}

	@objc private func closeButtonTapped(_ sender: UIBarButtonItem) {
		dismiss(animated: true)
	}
	
}

extension MenuViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.getNumberOfSections()
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.getNumberOfRowsInSection(section: section)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: MenuCellView.reuseIdentifier, for: indexPath) as? MenuCellView
		cell?.configure(with: viewModel, for: indexPath)
		return cell ?? MenuCellView()
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuHeaderView.reuseIdentifier) as? MenuHeaderView
		header?.configure(with: viewModel, for: section)
		return header ?? MenuHeaderView()
	}
}

extension MenuViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedCell = viewModel.getCellViewModel(for: indexPath)
		viewModel.menuCellTapped(with: selectedCell)
		// пуш контроллера навигейшеном тут или в роутере
		tableView.cellForRow(at: indexPath)?.isSelected = false
	}
}
