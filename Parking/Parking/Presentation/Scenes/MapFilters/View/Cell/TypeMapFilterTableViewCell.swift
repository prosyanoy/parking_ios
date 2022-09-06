//
//  TypeMapFilterTableViewCell.swift
//  Parking
//
//  Created by Maxim Terpugov on 30.08.2022.
//

import UIKit


final class TypeMapFilterTableViewCell: UITableViewCell {
    
    // MARK: - Static
    
    static let identifier = String(describing: TypeMapFilterTableViewCell.self)
    
    
    // MARK: - Dependencies
    
    private var viewModel: TypeMapFilterTableViewCellViewModelProtocol?
    
    
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
    
    func setupDependencies<VM>(viewModel: VM) {
        guard let vm = viewModel as? TypeMapFilterTableViewCellViewModelProtocol else {
            return
        }
        self.viewModel = vm
    }
    
    
    // MARK: - UI
    
    private lazy var freeCheckBoxLabel: UILabel = {
        let label = UILabel()
        label.text = "Бесплатная"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var freeCheckBoxButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.imageView?.layer.transform = CATransform3DMakeScale(1.3, 1.3, 0)
        button.imageView?.tintColor = .black.withAlphaComponent(0.3)
        button.addTarget(self, action: #selector(freeCheckBoxButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func freeCheckBoxButtonTapped() {
        let value = !freeCheckBoxButton.isSelected
        viewModel?.freeCheckBoxButtonTapped(isFree: value)
        updateFreeCheckBoxButton(isFree: value)
    }
    
    private lazy var freeHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [freeCheckBoxLabel,
                                                   freeCheckBoxButton])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        return stack
    }()
    
    
    private lazy var coveredCheckBoxLabel: UILabel = {
        let label = UILabel()
        label.text = "Крытая"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var coveredCheckBoxButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.imageView?.layer.transform = CATransform3DMakeScale(1.3, 1.3, 0)
        button.imageView?.tintColor = .black.withAlphaComponent(0.3)
        button.addTarget(self, action: #selector(coveredCheckBoxButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func coveredCheckBoxButtonTapped() {
        let value = !coveredCheckBoxButton.isSelected
        viewModel?.coveredCheckBoxButtonTapped(isSelected: value)
        updateCoveredCheckBoxButton(isCovered: value)
    }
    
    private lazy var coveredHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [coveredCheckBoxLabel,
                                                   coveredCheckBoxButton])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var totalVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [freeHorizontalStack,
                                                   coveredHorizontalStack])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func updateCoveredCheckBoxButton(isCovered: Bool) {
        coveredCheckBoxButton.isSelected = isCovered
        if isCovered {
            coveredCheckBoxButton.imageView?.tintColor = #colorLiteral(red: 0.6046196818, green: 0.4869016409, blue: 0.8574097753, alpha: 1)
        } else {
            coveredCheckBoxButton.imageView?.tintColor = .black.withAlphaComponent(0.3)
        }
    }
    
    private func updateFreeCheckBoxButton(isFree: Bool) {
        freeCheckBoxButton.isSelected = isFree
        if isFree {
            freeCheckBoxButton.imageView?.tintColor = #colorLiteral(red: 0.6046196818, green: 0.4869016409, blue: 0.8574097753, alpha: 1)
        } else {
            freeCheckBoxButton.imageView?.tintColor = .black.withAlphaComponent(0.3)
        }
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        contentView.addSubview(totalVerticalStack)
        
        totalVerticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        totalVerticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        totalVerticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        totalVerticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    
    // MARK: - Interface
    
    func setContent(isCovered: Bool, isFree: Bool) {
        updateCoveredCheckBoxButton(isCovered: isCovered)
        updateFreeCheckBoxButton(isFree: isFree)
    }
    
}

