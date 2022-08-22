//
//  SearchTableViewCell.swift
//  Parking
//
//  Created by Maxim Terpugov on 17.08.2022.
//

import UIKit


final class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Static

    static let identifier = String(describing: SearchTableViewCell.self)
    
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI

    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var costLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black.withAlphaComponent(0.8)
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [adressLabel,
                                                   costLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 3
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    // MARK: - Layout

    private func setupLayout() {
        contentView.addSubview(verticalStack)
        
        verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive
        = true
        verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    }
    
    
    // MARK: - Interface

    func setAdress(_ text: String) {
        adressLabel.text = text
    }
    
    func setCost(_ price: Float) {
        costLabel.text = "\(price)\u{2006}₽"
    }
    
}
