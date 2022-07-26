//
//  ViewController.swift
//  Parking
//
//  Created by Sofia Lupeko on 23.07.2022.
//

import UIKit
import YandexMapsMobile

class ViewController: UIViewController {
	var mapView: YMKMapView

	init(mapView: YMKMapView) {
		self.mapView = mapView
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupLayout()
		setupMapView()
	}

	private func setupMapView() {
		mapView.translatesAutoresizingMaskIntoConstraints = false

		let mapTarget = YMKPoint(latitude: 55.751574, longitude: 37.573856)
		mapView.mapWindow.map.move(
			with: YMKCameraPosition.init(target: mapTarget, zoom: 15, azimuth: 0, tilt: 0),
			animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
			cameraCallback: nil
		)
	}

	private func setupLayout() {
		view.addSubview(mapView)

		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalTo: view.topAnchor),
			mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
}

