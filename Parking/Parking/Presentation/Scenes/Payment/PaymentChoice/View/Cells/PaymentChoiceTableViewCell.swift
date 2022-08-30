//
//  PaymentChoiceTableViewCell.swift
//  Parking
//
//  Created by Maxim Terpugov on 24.08.2022.
//

import UIKit


final class PaymentChoiceTableViewCell: UITableViewCell {
    
    // MARK: - Static

    static let identifier = String(describing: UsersAutoTableViewCell.self)
    
    
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

    private lazy var paymentMethodView: PaymentMethodView = {
        let view = PaymentMethodView(frame: .zero)
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupLayout() {
        contentView.addSubview(paymentMethodView)
                
        paymentMethodView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        paymentMethodView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        paymentMethodView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        paymentMethodView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    
    // MARK: - Interface

    func setContent(title: String, description: String, icon: UIImage?) {
        paymentMethodView.setContent(title: title, description: description, icon: icon)
    }
    
}
