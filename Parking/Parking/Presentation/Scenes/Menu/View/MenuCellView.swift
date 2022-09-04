//
//  MenuCellView.swift
//  Parking
//
//  Created by Sofia Lupeko on 01.08.2022.
//

import UIKit

final class MenuCellView: UITableViewCell {
    
    static var reuseIdentifier: String { "\(Self.self)" }
    
    private let icon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .overpassMedium17
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()
    
    private let rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        icon.image = nil
        titleLabel.text = nil
        rightLabel.text = nil
    }
    
    private func configureUI() {
        backgroundColor = .white
        accessoryType = .disclosureIndicator
    }
    
    private func setupLayout() {
        addSubview(icon)
        addSubview(titleLabel)
        addSubview(rightLabel)
        
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.widthAnchor.constraint(equalTo: icon.heightAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -56),
            rightLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

extension MenuCellView {
    func configure(with menuViewModel: MenuViewModelProtocol, for indexPath: IndexPath) {
        let cell = menuViewModel.getCellViewModel(for: indexPath)
        icon.image = UIImage(named: cell.iconName)?.withTintColor(UIColor(red: 191/255, green: 61/255, blue: 163/255, alpha: 1))
        titleLabel.text = cell.title
        rightLabel.text = cell.rightText
    }
}



