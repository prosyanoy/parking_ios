//
//  MapButtonsView.swift
//  Parking
//
//  Created by Sofia Lupeko on 28.07.2022.
//

import Foundation
import UIKit

final class MapButtonsView: UIView {
	let main: UINavigationController
	private let menuButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(named: "List"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.tintColor = .black
		button.backgroundColor = .white
		button.layer.cornerRadius = 20
		button.layer.shadowRadius = 5
		button.layer.shadowOffset = CGSize(width: 4, height: 4)
		button.layer.shadowOpacity = 0.2
		button.layer.shadowColor = UIColor.black.cgColor
		return button
	}()

	private let cashView: CashView = {
		let view = CashView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	private let searchButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(named: "Glass"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.tintColor = .black
		button.backgroundColor = .white
		button.layer.cornerRadius = 20
		button.layer.shadowRadius = 5
		button.layer.shadowOffset = CGSize(width: 4, height: 4)
		button.layer.shadowOpacity = 0.2
		button.layer.shadowColor = UIColor.black.cgColor
		return button
	}()

	private let zoomPlusButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(named: "Plus"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.tintColor = .black
		button.backgroundColor = .white
		button.layer.cornerRadius = 20
		button.layer.shadowRadius = 5
		button.layer.shadowOffset = CGSize(width: 4, height: 4)
		button.layer.shadowOpacity = 0.2
		button.layer.shadowColor = UIColor.black.cgColor
		return button
	}()

	private let zoomMinusButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(named: "Minus"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.tintColor = .black
		button.backgroundColor = .white
		button.layer.cornerRadius = 20
		button.layer.shadowRadius = 5
		button.layer.shadowOffset = CGSize(width: 4, height: 4)
		button.layer.shadowOpacity = 0.2
		button.layer.shadowColor = UIColor.black.cgColor
		return button
	}()

	private let locationButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(named: "NavigationArrow"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.tintColor = .black
		button.backgroundColor = .white
		button.layer.cornerRadius = 20
		button.layer.shadowRadius = 5
		button.layer.shadowOffset = CGSize(width: 4, height: 4)
		button.layer.shadowOpacity = 0.2
		button.layer.shadowColor = UIColor.black.cgColor
		return button
	}()

	private let wheelchairButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(named: "Wheelchair"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.tintColor = .black
		button.backgroundColor = .white
		button.layer.cornerRadius = 20
		button.layer.shadowRadius = 5
		button.layer.shadowOffset = CGSize(width: 4, height: 4)
		button.layer.shadowOpacity = 0.2
		button.layer.shadowColor = UIColor.black.cgColor
		return button
	}()

	private let infoButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(named: "Info"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.tintColor = .black
		button.backgroundColor = .white
		button.layer.cornerRadius = 20
		button.layer.shadowRadius = 5
		button.layer.shadowOffset = CGSize(width: 4, height: 4)
		button.layer.shadowOpacity = 0.2
		button.layer.shadowColor = UIColor.black.cgColor
		return button
	}()
	#warning("fix")
	init(main: UINavigationController) {
		self.main = main
		super.init(frame: .zero)
		addTargets()
		setupLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		var hitTestView = super.hitTest(point, with: event)
		if hitTestView == self {
			hitTestView = nil
		}
		return hitTestView
	}

	private func addTargets() {
		menuButton.addTarget(self, action: #selector(menuButtonTapped(_:)), for: .touchUpInside)
		cashView.addTarget(self, action: #selector(cashViewTapped(_:)), for: .touchUpInside)
		searchButton.addTarget(self, action: #selector(searchButtonTapped(_:)), for: .touchUpInside)
		zoomPlusButton.addTarget(self, action: #selector(zoomPlusButtonTapped(_:)), for: .touchUpInside)
		zoomMinusButton.addTarget(self, action: #selector(zoomMinusButtonTapped(_:)), for: .touchUpInside)
		locationButton.addTarget(self, action: #selector(currentPlaceButtonTapped(_:)), for: .touchUpInside)
		wheelchairButton.addTarget(self, action: #selector(invalidButtonTapped(_:)), for: .touchUpInside)
		infoButton.addTarget(self, action: #selector(infoButtonTapped(_:)), for: .touchUpInside)
	}

	func setGradientBackground() {
		let colorEdge =  UIColor(white: 1, alpha: 0.5).cgColor
		let colorMiddle =  UIColor(white: 1, alpha: 0.1).cgColor
		let colorCenter = UIColor.clear.cgColor

		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [colorEdge, colorMiddle, colorCenter, colorMiddle, colorEdge]
		gradientLayer.locations = [0.0, 0.2, 0.5, 0.9, 1.0]
		gradientLayer.frame = bounds

		layer.insertSublayer(gradientLayer, at:0)
	}

	private func setupLayout() {
		addSubview(menuButton)
		addSubview(cashView)
		addSubview(searchButton)
		addSubview(zoomPlusButton)
		addSubview(zoomMinusButton)
		addSubview(locationButton)
		addSubview(wheelchairButton)
		addSubview(infoButton)

		NSLayoutConstraint.activate([
			menuButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
			menuButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			menuButton.widthAnchor.constraint(equalToConstant: 40),
			menuButton.heightAnchor.constraint(equalTo: menuButton.widthAnchor),

			cashView.centerXAnchor.constraint(equalTo: centerXAnchor),
			cashView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),

			searchButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
			searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			searchButton.widthAnchor.constraint(equalToConstant: 40),
			searchButton.heightAnchor.constraint(equalTo: searchButton.widthAnchor),

			locationButton.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -20),
			locationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			locationButton.widthAnchor.constraint(equalToConstant: 40),
			locationButton.heightAnchor.constraint(equalTo: locationButton.widthAnchor),

			zoomMinusButton.bottomAnchor.constraint(equalTo: locationButton.topAnchor, constant: -20),
			zoomMinusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			zoomMinusButton.widthAnchor.constraint(equalToConstant: 40),
			zoomMinusButton.heightAnchor.constraint(equalTo: zoomMinusButton.widthAnchor),

			zoomPlusButton.bottomAnchor.constraint(equalTo: zoomMinusButton.topAnchor, constant: -2),
			zoomPlusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			zoomPlusButton.widthAnchor.constraint(equalToConstant: 40),
			zoomPlusButton.heightAnchor.constraint(equalTo: zoomPlusButton.widthAnchor),

			wheelchairButton.topAnchor.constraint(equalTo: centerYAnchor, constant: 20),
			wheelchairButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			wheelchairButton.widthAnchor.constraint(equalToConstant: 40),
			wheelchairButton.heightAnchor.constraint(equalTo: wheelchairButton.widthAnchor),

			infoButton.topAnchor.constraint(equalTo: wheelchairButton.bottomAnchor, constant: 20),
			infoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			infoButton.widthAnchor.constraint(equalToConstant: 40),
			infoButton.heightAnchor.constraint(equalTo: infoButton.widthAnchor),
		])
	}

	@objc private func menuButtonTapped(_ sender: UIButton) {
		let menuVC = MenuConfigurator.configure()
		self.main.present(menuVC, animated: true)
	}

	@objc private func cashViewTapped(_ sender: UIButton) {
		print("cashViewTapped")
	}
	@objc private func searchButtonTapped(_ sender: UIButton) {
		print("searchButtonTapped")
	}
	@objc private func zoomPlusButtonTapped(_ sender: UIButton) {
		print("zoomPlusButtonTapped")
	}
	@objc private func zoomMinusButtonTapped(_ sender: UIButton) {
		print("zoomMinusButtonTapped")
	}
	@objc private func currentPlaceButtonTapped(_ sender: UIButton) {
		print("currentPlaceButtonTapped")
	}
	@objc private func invalidButtonTapped(_ sender: UIButton) {
		print("invalidButtonTapped")
	}
	@objc private func infoButtonTapped(_ sender: UIButton) {
		print("infoButtonTapped")
	}
}
