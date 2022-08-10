//
//  TimeTableViewCell.swift
//  Parking
//
//  Created by Maxim Terpugov on 09.08.2022.
//

import UIKit


final class TimeTableViewCell: UITableViewCell {
    
    // MARK: - Static

    static let identifier = String(describing: TimeTableViewCell.self)
    
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI

    private lazy var titleTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descriptionTimeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("1 час", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.tintColor = .systemBlue
        button.addTarget(self,
                         action: #selector(descriptionAutoButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func descriptionAutoButtonTapped() {
        print("descriptionAutoButtonTapped")
    }
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleTimeLabel,
                                                   descriptionTimeButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private func setupLayout() {
        contentView.addSubview(horizontalStack)
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        horizontalStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    
}
