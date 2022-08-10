//
//  ParkingTableViewCell.swift
//  Parking
//
//  Created by Maxim Terpugov on 09.08.2022.
//

import UIKit

final class ParkingTableViewCell: UITableViewCell {
    
    // MARK: - Static

    static let identifier = String(describing: ParkingTableViewCell.self)
    
    
    // MARK: - Dependencies

    private var invalidateInternalCellSizeCallback: (() -> Void)?
    
    
    // MARK: - State

    var isCollapsedCell = true
    
    
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
    
    func setupDependencies(invalidateInternalCellSizeCallback: @escaping () -> Void) {
        self.invalidateInternalCellSizeCallback = invalidateInternalCellSizeCallback
    }
    
    
    // MARK: - UI
    // Collapsed frame
    
    private lazy var titleParkingLabel: UILabel = {
        let label = UILabel()
        label.text = "Парковка"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descriptionParkingButton: LabelContentSizedButton = {
        let button = LabelContentSizedButton(type: .system)
        button.setTitle("none", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.tintColor = .systemBlue
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .left
        button.addTarget(self,
                         action: #selector(descriptionAutoButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func descriptionAutoButtonTapped() {
    }
    
    private lazy var moreDetailButton: LabelContentSizedButton = {
        let button = LabelContentSizedButton(type: .system)
        button.setTitle("подробнее", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.titleLabel?.numberOfLines = 1
        button.tintColor = .systemBlue
        button.titleLabel?.textAlignment = .left
        button.addTarget(self,
                         action: #selector(moreDetailButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    @objc private func moreDetailButtonTapped() {
        expandCell()
    }
    
    private lazy var descriptionVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [descriptionParkingButton,
                                                   moreDetailButton])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 3
        return stack
    }()
    
    private lazy var collapsedHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleParkingLabel,
                                                   descriptionVerticalStack])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    
    // Expanded frame
    private lazy var detailTitleAdressLabel: UILabel = {
        let label = UILabel()
        label.text = "Адрес"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var detailDescriptionAdressLabel: UILabel = {
        let label = UILabel()
        label.text = "none"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var detailAdressHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [detailTitleAdressLabel,
                                                   detailDescriptionAdressLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    private lazy var detailTitleCostLabel: UILabel = {
        let label = UILabel()
        label.text = "Цена за час"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var detailDescriptionCostLabel: UILabel = {
        let label = UILabel()
        label.text = "none"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var detailCostHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [detailTitleCostLabel,
                                                   detailDescriptionCostLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    private lazy var detailVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [detailAdressHorizontalStack,
                                                   detailCostHorizontalStack])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.isHidden = true
        stack.alpha = 0
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 15, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.backgroundColor = .systemGray5
        return stack
    }()
    
    
    private lazy var totalVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [collapsedHorizontalStack,
                                                   detailVerticalStack])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    
    // MARK: - Layout

    private func setupLayout() {
        contentView.addSubview(totalVerticalStack)
        totalVerticalStack.translatesAutoresizingMaskIntoConstraints = false
        totalVerticalStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        totalVerticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        totalVerticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        totalVerticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        detailVerticalStack.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        descriptionParkingButton.titleLabel?.leadingAnchor.constraint(equalTo: descriptionVerticalStack.leadingAnchor).isActive = true
    }
    

    // MARK: - Interface

    func setParkingLabel(_ text: String) {
        descriptionParkingButton.setTitle(text, for: .normal)
    }
    
    func setParkingAdress(_ text: String) {
        detailDescriptionAdressLabel.text = text
    }
    
    func setParkingCost(_ text: String) {
        let strCost = "\(text)\u{2006}₽"
        detailDescriptionCostLabel.text = strCost
    }
    
    func collapseCell() {
        guard !isCollapsedCell else { return }
        moreDetailButton.isHidden = false
        moreDetailButton.alpha = 1
        UIView.animate(withDuration: 0.35,
                       delay: 0,
                       options: [.curveEaseIn],
                       animations: {
            self.detailVerticalStack.isHidden = true
            self.detailVerticalStack.alpha = 0
            self.contentView.layoutIfNeeded()
            self.invalidateInternalCellSizeCallback?()
        }, completion: { _ in
            self.isCollapsedCell = true
        } )
    }
    
    func expandCell() {
        guard isCollapsedCell else { return }
        moreDetailButton.isHidden = true
        moreDetailButton.alpha = 0
        UIView.animate(withDuration: 0.35,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: {
            self.detailVerticalStack.isHidden = false
            self.detailVerticalStack.alpha = 1
            self.contentView.layoutIfNeeded()
            self.invalidateInternalCellSizeCallback?()
        }, completion: { _ in
            self.isCollapsedCell = false
        })
    }
}



