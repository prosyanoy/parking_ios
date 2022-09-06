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
    private let yMapDrawer: MainMapYMKDrawerProtocol
    private let yMapView: YMKMapView
    private let mapButtonsView: MapButtonsView

    
    // MARK: - Init
    
    init(viewModel: MainMapViewModelProtocol,
         yMapDrawer: MainMapYMKDrawerProtocol,
         yMapView: YMKMapView,
         mapButtonsView: MapButtonsView,
         nibName nibNameOrNil: String?,
         bundle nibBundleOrNil: Bundle?) {
        self.viewModel = viewModel
        self.yMapDrawer = yMapDrawer
        self.yMapView = yMapView
        self.mapButtonsView = mapButtonsView
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
        user.notify()
    }

	override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapButtonsView.setGradientBackground()
	}
	
    
    // MARK: - Input data flow
    
    private func setupObservers() {
//        viewModel.parkings.subscribe(observer: self) { [weak self] parkings in
            //update data callback...
//        }
    }

    
    // MARK: - Layout
    
    private func setupLayout() {
		yMapView.translatesAutoresizingMaskIntoConstraints = false
        mapButtonsView.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(yMapView)
		view.addSubview(mapButtonsView)

		NSLayoutConstraint.activate([
            yMapView.topAnchor.constraint(equalTo: view.topAnchor),
            yMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            yMapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            yMapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            mapButtonsView.topAnchor.constraint(equalTo: view.topAnchor),
            mapButtonsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapButtonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapButtonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
    }
    
}
