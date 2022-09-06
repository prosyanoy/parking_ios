//
//  ServicesFiltersMapTableViewCell.swift
//  Parking
//
//  Created by Maxim Terpugov on 30.08.2022.
//

import UIKit


final class ServicesMapFilterTableViewCell: UITableViewCell {
    
    // MARK: - Static
    
    static let identifier = String(describing: ServicesMapFilterTableViewCell.self)
    
    
    // MARK: - Dependencies
    
    private var viewModel: ServicesMapFilterTableViewCellViewModelProtocol?
    
    
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
        guard let vm = viewModel as? ServicesMapFilterTableViewCellViewModelProtocol else {
            return
        }
        self.viewModel = vm
    }
    
    
    // MARK: - UI
    
    // SECURE
    private lazy var secureButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: "checkmark.shield"), for: .normal)
//        button.setImage(UIImage(systemName: "checkmark.shield.fill"), for: .selected)
        button.setImage(UIImage(named: "Secure"), for: .normal)
        button.setImage(UIImage(named: "SecureQ"), for: .selected)
        button.imageView?.layer.transform = CATransform3DMakeScale(2.1, 2, 0) // 2.2 2
        button.imageView?.tintColor = #colorLiteral(red: 0.6046196818, green: 0.4869016409, blue: 0.8574097753, alpha: 1)
        button.addTarget(self, action: #selector(secureButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc private func secureButtonTapped() {
        let value = !secureButton.isSelected
        viewModel?.secureButtonTapped(isSelected: value)
        updateSecureButton(isSelected: value)
    }
    
    private func updateSecureButton(isSelected: Bool) {
        secureButton.isSelected = isSelected
    }
    
    private lazy var secureTitle: UILabel = {
        let label = UILabel()
        label.text = "Охраняемая парковка"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var secureVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [secureButton,
                                                   secureTitle])
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    // AROUND THE CLOCK
    private lazy var aroundTheClockButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: "24.square"), for: .normal)
//        button.setImage(UIImage(systemName: "24.square.fill"), for: .selected)
        button.setImage(UIImage(named: "247"), for: .normal)
        button.setImage(UIImage(named: "247Q"), for: .selected)
        button.imageView?.layer.transform = CATransform3DMakeScale(2.1, 2, 0) //2.2 2.1
        button.imageView?.tintColor = #colorLiteral(red: 0.6046196818, green: 0.4869016409, blue: 0.8574097753, alpha: 1)
        button.addTarget(self, action: #selector(aroundTheClockButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc private func aroundTheClockButtonTapped() {
        let value = !aroundTheClockButton.isSelected
        viewModel?.aroundTheClockButtonTapped(isSelected: value)
        updateAroundTheClockButton(isSelected: value)
    }
    
    private func updateAroundTheClockButton(isSelected: Bool) {
        aroundTheClockButton.isSelected = isSelected
    }
    
    private lazy var aroundTheClockTitle: UILabel = {
        let label = UILabel()
        label.text = "Работает круглосуточно"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var aroundTheClockVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [aroundTheClockButton,
                                                   aroundTheClockTitle])
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    // EV CHARGING
    private lazy var evChargingButton: UIButton = {
        let button = UIButton()
//        Системная картинка доступна с iOS 15+
//        button.setImage(UIImage(systemName: "bolt.batteryblock"), for: .normal)
//        button.setImage(UIImage(systemName: "bolt.batteryblock.fill"), for: .selected)
        button.setImage(UIImage(named: "Charg"), for: .normal)
        button.setImage(UIImage(named: "ChargQ"), for: .selected)
        button.imageView?.layer.transform = CATransform3DMakeScale(2.1, 2, 0) // 2 2
        button.imageView?.tintColor = #colorLiteral(red: 0.6046196818, green: 0.4869016409, blue: 0.8574097753, alpha: 1)
        button.addTarget(self, action: #selector(evChargingButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc private func evChargingButtonTapped() {
        let value = !evChargingButton.isSelected
        viewModel?.evChargingButtonTapped(isSelected: value)
        updateEvChargingButton(isSelected: value)
    }
    
    private func updateEvChargingButton(isSelected: Bool) {
        evChargingButton.isSelected = isSelected
    }
    
    private lazy var evChargingTitle: UILabel = {
        let label = UILabel()
        label.text = "С электро зарядкой"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var evChargingVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [evChargingButton,
                                                   evChargingTitle])
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    // DISABLED PERSONS
    private lazy var disabledPersonsButton: UIButton = {
        let button = UIButton()
//        Системная картинка доступна с iOS 15+
//        button.setImage(UIImage(systemName: "figure.roll"), for: .normal)
        button.setImage(UIImage(named: "Disab"), for: .normal)
        button.setImage(UIImage(named: "DisabQ"), for: .selected)
        button.imageView?.layer.transform = CATransform3DMakeScale(2.1, 2, 0)
        button.imageView?.layer.cornerRadius = 2
        button.imageView?.tintColor = #colorLiteral(red: 0.6046196818, green: 0.4869016409, blue: 0.8574097753, alpha: 1)
        button.addTarget(self, action: #selector(disabledPersonsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func disabledPersonsButtonTapped() {
        let value = !disabledPersonsButton.isSelected
        viewModel?.disabledPersonsButtonTapped(isSelected: value)
        updateDisabledPersonsButton(isSelected: value)
    }
    
    private func updateDisabledPersonsButton(isSelected: Bool) {
        disabledPersonsButton.isSelected = isSelected
    }
    
    private lazy var disabledPersonsTitle: UILabel = {
        let label = UILabel()
        label.text = "Места для инвалидов"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var disabledVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [disabledPersonsButton,
                                                   disabledPersonsTitle])
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    // TOTAL
    private lazy var totalHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [secureVerticalStack,
                                                   aroundTheClockVerticalStack,
                                                   evChargingVerticalStack,
                                                   disabledVerticalStack])
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .top
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    // MARK: - Layout

    private func setupLayout() {
        contentView.addSubview(totalHorizontalStack)
        
        totalHorizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        totalHorizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        totalHorizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        totalHorizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    
    // MARK: - Interface

    func setContent(secureValue: Bool,
                    aroundTheClockValue: Bool,
                    evChargingValue: Bool,
                    disabledValue: Bool) {
        updateSecureButton(isSelected: secureValue)
        updateAroundTheClockButton(isSelected: aroundTheClockValue)
        updateEvChargingButton(isSelected: evChargingValue)
        updateDisabledPersonsButton(isSelected: disabledValue)
    }
    
}
