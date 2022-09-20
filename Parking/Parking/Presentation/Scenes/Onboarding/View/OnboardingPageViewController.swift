//
//  OnboardingViewController.swift
//  Parking
//
//  Created by Denis Zagudaev on 21.08.2022.
//

import UIKit

class OnboardingPageViewController: UIViewController {
    
    let stackView: UIStackView = {
        let sw = UIStackView()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.axis = .vertical
        sw.alignment = .center
        sw.spacing = 20
        return sw
    }()
    let imageView: UIImageView = {
        let iw = UIImageView()
        iw.translatesAutoresizingMaskIntoConstraints = false
        iw.contentMode = .scaleAspectFill
        return iw
    }()
    let titleLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)
        lable.font = .overpassBold20
        lable.numberOfLines = 2
        lable.textAlignment = .center
        return lable
    }()
    let subtitleLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)
        lable.font = .overpassMedium16
        lable.textAlignment = .center
        lable.numberOfLines = 2
        return lable
    }()
    
    init(imageName: String, titleText: String, subtitleText: String) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = UIImage(named: imageName)
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        setupLayout()
    }
}

extension OnboardingPageViewController {

    func setupLayout() {
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        view.addSubview(stackView)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
        
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  44),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 120),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subtitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1.5),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: subtitleLabel.trailingAnchor, multiplier: 1.5)
        ])
    }
}
