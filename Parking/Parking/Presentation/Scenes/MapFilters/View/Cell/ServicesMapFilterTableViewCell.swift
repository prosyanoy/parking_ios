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
    
    // Secure
    private lazy var titleSecureSwitchLabel: UILabel = {
        let label = UILabel()
        label.text = "Безопасная"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var secureSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.onTintColor = #colorLiteral(red: 0.6046196818, green: 0.4869016409, blue: 0.8574097753, alpha: 1)
        uiSwitch.addTarget(self,
                           action: #selector(secureSwitchValueDidChange),
                           for: .valueChanged)
        return uiSwitch
    }()
    
    @objc private func secureSwitchValueDidChange() {
        viewModel?.secureSwitchValueDidChange(isOn: secureSwitch.isOn)
    }
    
    private lazy var secureHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleSecureSwitchLabel,
                                                   secureSwitch])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    // 24/7
    private lazy var titleAroundTheClockSwitchLabel: UILabel = {
        let label = UILabel()
        label.text = "Круглосуточная"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var aroundTheClockSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.onTintColor = #colorLiteral(red: 0.6046196818, green: 0.4869016409, blue: 0.8574097753, alpha: 1)
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        uiSwitch.addTarget(self,
                           action: #selector(aroundTheClockSwitchValueDidChange),
                           for: .valueChanged)
        return uiSwitch
    }()
    
    @objc private func aroundTheClockSwitchValueDidChange() {
        viewModel?.aroundTheClockSwitchValueDidChange(isOn: aroundTheClockSwitch.isOn)
    }
    
    private lazy var aroundTheClockHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleAroundTheClockSwitchLabel,
                                                   aroundTheClockSwitch])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    // EV Charging
    private lazy var titleEvChargingSwitchLabel: UILabel = {
        let label = UILabel()
        label.text = "С подзарядкой"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var eVChargingSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.onTintColor = #colorLiteral(red: 0.6046196818, green: 0.4869016409, blue: 0.8574097753, alpha: 1)
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        uiSwitch.addTarget(self,
                           action: #selector(eVChargingSwitchValueDidChange),
                           for: .valueChanged)
        return uiSwitch
    }()
    
    @objc private func eVChargingSwitchValueDidChange() {
        viewModel?.eVChargingSwitchValueDidChange(isOn: eVChargingSwitch.isOn)
    }
    
    private lazy var eVChargingHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleEvChargingSwitchLabel,
                                                   eVChargingSwitch])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    // Disabled persons
    private lazy var disabledSwitchLabel: UILabel = {
        let label = UILabel()
        label.text = "Наличие мест для инвалидов"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var disabledSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.onTintColor = #colorLiteral(red: 0.6046196818, green: 0.4869016409, blue: 0.8574097753, alpha: 1)
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        uiSwitch.addTarget(self,
                           action: #selector(disabledSwitchValueDidChange),
                           for: .valueChanged)
        return uiSwitch
    }()
    
    @objc private func disabledSwitchValueDidChange() {
        viewModel?.disabledSwitchValueDidChange(isOn: disabledSwitch.isOn)
    }
    
    private lazy var disabledHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [disabledSwitchLabel,
                                                   disabledSwitch])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var totalVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [secureHorizontalStack,
                                                   aroundTheClockHorizontalStack,
                                                   eVChargingHorizontalStack,
                                                   disabledHorizontalStack])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    // MARK: - Layout
    
    private func setupLayout() {
        contentView.addSubview(totalVerticalStack)
        
        totalVerticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        totalVerticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        totalVerticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        totalVerticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    // MARK: - Interface

    func setContent(secureValue: Bool,
                    aroundTheClockValue: Bool,
                    evChargingValue: Bool,
                    disabledValue: Bool) {
            self.secureSwitch.setOn(secureValue, animated: false)
            self.aroundTheClockSwitch.setOn(aroundTheClockValue, animated: false)
            self.eVChargingSwitch.setOn(evChargingValue, animated: false)
            self.disabledSwitch.setOn(disabledValue, animated: false)
    }
    
}
