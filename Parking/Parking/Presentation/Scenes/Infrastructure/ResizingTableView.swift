//
//  ResizingTableView.swift
//  Parking
//
//  Created by Maxim Terpugov on 09.08.2022.
//

import UIKit


final class ResizingTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
