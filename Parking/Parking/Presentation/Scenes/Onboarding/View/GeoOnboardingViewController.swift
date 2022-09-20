//
//  OnboardingViewController.swift
//  Parking
//
//  Created by Denis Zagudaev on 21.08.2022.
//

import UIKit

class GeoOnboardingViewController: UIViewController{
    let defaults = UserDefaults.standard
    
    let imageView: UIImageView = {
        let iw = UIImageView()
        iw.translatesAutoresizingMaskIntoConstraints = false
        iw.contentMode = .scaleAspectFill
        return iw
    }()
    let titleLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        lable.numberOfLines = 4
        lable.textAlignment = .center
        lable.font = .overpassBold20
        return lable
    }()
    
    init(imageName: String, titleText: String) {
        super.init(nibName: nil, bundle: nil)
        self.imageView.image = UIImage(named: imageName)
        self.titleLable.text = titleText
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        setupLayout()
        defaults.removeObject(forKey: "numberOfCar")
        defaults.removeObject(forKey: "userPhoneNumber")
        defaults.removeObject(forKey: "typeOfCar")
        defaults.removeObject(forKey: "Pnone")
    }
}
extension GeoOnboardingViewController {

    func setupLayout() {
        view.addSubview(imageView)
        view.addSubview(titleLable)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            titleLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLable.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLable.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: titleLable.leadingAnchor, multiplier: 4)
        ])
    }
}

