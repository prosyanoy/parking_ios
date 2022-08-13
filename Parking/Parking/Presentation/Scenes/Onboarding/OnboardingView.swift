//
//  OnboardingView.swift
//  Parking
//
//  Created by Mikhail Chudaev on 13.08.2022.
//

import Foundation
import UIKit

class OnboardingView: UIView {
    
    let testDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let testImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    init(labelText: String, imageName: String) {
        testDescriptionLabel.text = labelText
        testImageView.image = UIImage(named: imageName)
        super.init(frame: .zero)
        setupLayout()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(testDescriptionLabel)
        addSubview(testImageView)

        NSLayoutConstraint.activate([
            testDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            testDescriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            
            testImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            testImageView.topAnchor.constraint(equalTo: testDescriptionLabel.bottomAnchor, constant: 50),
            testImageView.widthAnchor.constraint(equalToConstant: 200),
            testImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }

    private func configureUI() {
        let viewLightWhiteBackgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        backgroundColor = viewLightWhiteBackgroundColor
    }
}
