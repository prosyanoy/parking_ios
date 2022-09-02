//
//  MapFiltersTableViewHeader.swift
//  Parking
//
//  Created by Maxim Terpugov on 02.09.2022.
//

import UIKit


final class MapFiltersTableViewHeader: UITableViewHeaderFooterView {
    
    // MARK: - Static
    
    static let identifier = String(describing: MapFiltersTableViewHeader.self)

    
    // MARK: - Init

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupInititalUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI
    
    private func setupInititalUI() {
        contentView.backgroundColor = .white
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    // MARK: - Layout

    private func setupLayout() {
        contentView.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    
    // MARK: - Interface

    func setContent(title: String) {
        self.titleLabel.text = title
    }
   
}
