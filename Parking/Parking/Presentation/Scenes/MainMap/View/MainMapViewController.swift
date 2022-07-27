//
//  MainMapViewController.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.07.2022.
//

import UIKit


final class MainMapViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private let viewModel: MainMapViewModelProtocol
    
    
    // MARK: - Init
    
    init(viewModel: MainMapViewModelProtocol,
         nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?) {
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
        view.backgroundColor = .red
        view.addSubview(parkingButton)
        setupLayout()
    }
    
    
    // MARK: - Input data flow
    
    private func setupObservers() {
        viewModel.parkings.subscribe(observer: self) { [weak self] parkings in
            //update data callback...
        }
    }
    
    private lazy var parkingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "p.circle"),
                        for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 35
        button.addTarget(self, action: #selector(parkingButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func parkingButtonTapped() {
        viewModel.parkingButtonTapped()
    }
    
    private func setupLayout() {
        parkingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        parkingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        parkingButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        parkingButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
}
