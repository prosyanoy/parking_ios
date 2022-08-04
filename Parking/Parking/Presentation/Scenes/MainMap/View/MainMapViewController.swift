//
//  MainMapViewController.swift
//  Parking
//
//  Created by Maxim Terpugov on 26.07.2022.
//

import UIKit
import YandexMapsMobile

final class MainMapViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private let viewModel: MainMapViewModelProtocol
    private let mapButtonsLayer: MapButtonsView
    private let mapView: YMKMapView
    private let yMapDrawer: MainMapYMKDrawerProtocol

    
    // MARK: - Init
    
    init(viewModel: MainMapViewModelProtocol,
         mapButtons: MapButtonsView,
		 mapView: YMKMapView,
         yMapDrawer: MainMapYMKDrawerProtocol,
         nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?) {
        self.mapButtonsLayer = mapButtons
        self.viewModel = viewModel
        self.mapView = mapView
        self.yMapDrawer = yMapDrawer
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        yMapDrawer.setupYMapView()
        setupObservers()
        viewModel.viewDidLoad()
    }

	override func viewDidLayoutSubviews() {
		mapButtonsLayer.setGradientBackground()
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
		mapView.translatesAutoresizingMaskIntoConstraints = false
		mapButtonsLayer.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(mapView)
		view.addSubview(mapButtonsLayer)
		view.addSubview(parkingButton)

		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalTo: view.topAnchor),
			mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			mapButtonsLayer.topAnchor.constraint(equalTo: view.topAnchor),
			mapButtonsLayer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			mapButtonsLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mapButtonsLayer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])

        parkingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        parkingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        parkingButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        parkingButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
}
