//
//  ParkingSearchTableViewCell.swift
//  Parking
//
//  Created by Maxim Terpugov on 19.08.2022.
//

import UIKit


final class ParkingSearchTableViewCell: UITableViewCell {
    
    // MARK: - Static

    static let identifier = String(describing: ParkingSearchTableViewCell.self)
    
    
    // MARK: - Dependencies

    private var viewModel: ParkingSearchBottomSheetViewModelProtocol?
    
    
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
    
    func setupDependencies(viewModel: ParkingSearchBottomSheetViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - UI
    
    private lazy var titleParkingLabel: UILabel = {
        let label = UILabel()
        label.text = "Парковка"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var parkingSearchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Поиск", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.tintColor = .systemBlue
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .left
        button.titleEdgeInsets.left = 3
        let image = UIImage(systemName: "magnifyingglass")
        let scaledImage = image?.scale(toSize: CGSize(width: 20, height: 18))
        button.setImage(scaledImage, for: .normal)
        button.addTarget(self,
                         action: #selector(parkingSearchButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func parkingSearchButtonTapped() {
        viewModel?.parkingSearchButtonTapped()
    }
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleParkingLabel,
                                                   parkingSearchButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func setupLayout() {
        contentView.addSubview(horizontalStack)
        horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        horizontalStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
}
