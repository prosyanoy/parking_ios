//
//  PaymentMethodView.swift
//  Parking
//
//  Created by Maxim Terpugov on 17.08.2022.
//

import UIKit

final class PaymentMethodView: UIControl {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI
    
    private func setupUI() {
        backgroundColor = .white
        layer.borderColor = UIColor.blue.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
    }
    
    private lazy var leadingIconImage: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = false
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Банковская карта"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Без привзяки. Комиссия: 0,7-1,0%, минимум 5\u{2006}₽"
        label.font = .systemFont(ofSize: 13, weight: .thin)
        label.textColor = .black.withAlphaComponent(0.9)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [titleLabel,descriptionLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.spacing = 2
        stack.isUserInteractionEnabled = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var trailingIconImage: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = false
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .lightGray : .white
        }
    }
    
    
    // MARK: - Layout
    
    private func setupLayout() {
        addSubview(leadingIconImage)
        addSubview(verticalStack)
        addSubview(trailingIconImage)
        
        leadingIconImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        leadingIconImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        
        verticalStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        verticalStack.leadingAnchor.constraint(equalTo: leadingIconImage.trailingAnchor, constant: 5).isActive = true
        verticalStack.trailingAnchor.constraint(equalTo: trailingIconImage.leadingAnchor, constant: -20).isActive = true
        
        trailingIconImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        trailingIconImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
    }
    
}
