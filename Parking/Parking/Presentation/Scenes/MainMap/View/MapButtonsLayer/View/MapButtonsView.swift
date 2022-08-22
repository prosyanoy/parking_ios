//
//  MapButtonsView.swift
//  Parking
//
//  Created by Sofia Lupeko on 28.07.2022.
//

import Foundation
import UIKit

final class MapButtonsView: UIView {
    
    // MARK: - Dependencies

	let targetDelegate: MainMapButtonsLayerDelegateProtocol
    
    
    // MARK: - Init

    init(targetDelegate: MainMapButtonsLayerDelegateProtocol) {
        self.targetDelegate = targetDelegate
        super.init(frame: .zero)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI
    
	private lazy var menuButton: UIButton = {
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
        button.addTarget(self, action: #selector(menuButtonTapped(_:)), for: .touchUpInside)
		return button
	}()
    
    @objc private func menuButtonTapped(_ sender: UIButton) {
        targetDelegate.menuButtonTapped()
    }

    private lazy var cashView: CashView = {
		let view = CashView()
		view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(cashViewTapped(_:)), for: .touchUpInside)
		return view
	}()
    
    @objc private func cashViewTapped(_ sender: UIButton) {
        targetDelegate.cashViewTapped()
    }

    private lazy var searchButton: UIButton = {
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
        button.addTarget(self, action: #selector(searchButtonTapped(_:)), for: .touchUpInside)
		return button
	}()
    
    @objc private func searchButtonTapped(_ sender: UIButton) {
        targetDelegate.searchButtonTapped()
    }

    private lazy var zoomPlusButton: UIButton = {
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
        button.addTarget(self, action: #selector(zoomPlusButtonTapped(_:)), for: .touchUpInside)
		return button
	}()
    
    @objc private func zoomPlusButtonTapped(_ sender: UIButton) {
        targetDelegate.zoomPlusButtonTapped()
    }

    private lazy var zoomMinusButton: UIButton = {
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
        button.addTarget(self, action: #selector(zoomMinusButtonTapped(_:)), for: .touchUpInside)
		return button
	}()
    
    @objc private func zoomMinusButtonTapped(_ sender: UIButton) {
        targetDelegate.zoomMinusButtonTapped()
    }

    private lazy var locationButton: UIButton = {
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
        button.addTarget(self, action: #selector(locationButtonTapped(_:)), for: .touchUpInside)
		return button
	}()
    
    @objc private func locationButtonTapped(_ sender: UIButton) {
        targetDelegate.locationButtonTapped()
    }

    private lazy var invalidButton: UIButton = {
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
        button.addTarget(self, action: #selector(invalidButtonTapped(_:)), for: .touchUpInside)
		return button
	}()
    
    @objc private func invalidButtonTapped(_ sender: UIButton) {
        targetDelegate.invalidButtonTapped()
    }

    private lazy var infoButton: UIButton = {
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
        button.addTarget(self, action: #selector(infoButtonTapped(_:)), for: .touchUpInside)
		return button
	}()
    
    @objc private func infoButtonTapped(_ sender: UIButton) {
    }
    
    private lazy var searchParkingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "p.circle"),
                        for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 35
        button.addTarget(self, action: #selector(searchParkingButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func searchParkingButtonTapped() {
        targetDelegate.searchParkingButtonTapped()
    }


	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		var hitTestView = super.hitTest(point, with: event)
		if hitTestView == self {
			hitTestView = nil
		}
		return hitTestView
	}

	func setGradientBackground() {
		let colorEdge =  UIColor(white: 1, alpha: 0.5).cgColor
		let colorMiddle =  UIColor(white: 1, alpha: 0.1).cgColor
		let colorCenter = UIColor.clear.cgColor

		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [colorEdge, colorMiddle, colorCenter, colorMiddle, colorEdge]
		gradientLayer.locations = [0.0, 0.2, 0.5, 0.9, 1.0]
		gradientLayer.frame = bounds
        // Cлои накладываются друг на друга каждый вызов
		layer.insertSublayer(gradientLayer, at:0)
	}

	private func setupLayout() {
		addSubview(menuButton)
		addSubview(cashView)
		addSubview(searchButton)
		addSubview(zoomPlusButton)
		addSubview(zoomMinusButton)
		addSubview(locationButton)
		addSubview(invalidButton)
		addSubview(infoButton)
        addSubview(searchParkingButton)

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

			invalidButton.topAnchor.constraint(equalTo: centerYAnchor, constant: 20),
			invalidButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			invalidButton.widthAnchor.constraint(equalToConstant: 40),
			invalidButton.heightAnchor.constraint(equalTo: invalidButton.widthAnchor),

			infoButton.topAnchor.constraint(equalTo: invalidButton.bottomAnchor, constant: 20),
			infoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			infoButton.widthAnchor.constraint(equalToConstant: 40),
			infoButton.heightAnchor.constraint(equalTo: infoButton.widthAnchor),
            
            searchParkingButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchParkingButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            searchParkingButton.widthAnchor.constraint(equalToConstant: 70),
            searchParkingButton.heightAnchor.constraint(equalToConstant: 70)
		])
	}

}
