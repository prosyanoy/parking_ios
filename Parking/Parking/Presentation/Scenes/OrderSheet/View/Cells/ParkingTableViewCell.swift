//
//  ParkingTableViewCell.swift
//  Parking
//
//  Created by Maxim Terpugov on 09.08.2022.
//

import UIKit

final class ParkingTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: ParkingTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
