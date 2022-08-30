//
//  UsersAutoTableViewCell.swift
//  Parking
//
//  Created by Maxim Terpugov on 09.08.2022.
//

import UIKit


final class UsersAutoTableViewCell: UITableViewCell {
    
    // MARK: - Static

    static let identifier = String(describing: UsersAutoTableViewCell.self)
    
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupLayout()
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Input data flow

    private func setupObservers() {
        user.subscribe(observer: self) { [weak self] user in
            self?.descriptionAutoButton.setTitle(user.licencePlate, for: .normal)
        }
    }
    
    
    // MARK: - UI

    private lazy var titleAutoLabel: UILabel = {
        let label = UILabel()
        label.text = "Автомобиль"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descriptionAutoButton: UIButton = {
        let button = UIButton(type: .system)
//        button.setTitle("А 777 АА 777", for: .normal)
        button.titleLabel?.tintColor = .systemBlue
        button.titleLabel?.textAlignment = .left
        button.addTarget(self,
                         action: #selector(descriptionAutoButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func descriptionAutoButtonTapped() {
        print("descriptionAutoButtonTapped")
    }
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleAutoLabel,
                                                   descriptionAutoButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    
    // MARK: - Layout

    private func setupLayout() {
        contentView.addSubview(horizontalStack)
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        horizontalStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
}
