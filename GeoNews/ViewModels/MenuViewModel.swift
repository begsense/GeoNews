//
//  MenuViewModel.swift
//  GeoNews
//
//  Created by M1 on 10.07.2024.
//

import Foundation

class MenuViewModel {
    var currentCellIdentifier: String = NewsTableViewCell.identifier {
        didSet {
            changeCellStyles?()
        }
    }

    var changeCellStyles: (() -> Void)?
}
