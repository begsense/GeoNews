//
//  CellStyleManager.swift
//  GeoNews
//
//  Created by M1 on 20.07.2024.
//

import Foundation

class CellStyleManager {
    static var shared = CellStyleManager()
    
    private init() {}
    
    var cellStyles = ["GeoNews", "AppleNews", "BBCNews", "FastNews", "CNNNews"]
    
    private var currentCellIdentifier: String = NewsTableViewCell.identifier {
        didSet {
            NotificationCenter.default.post(name: .cellStyleChanged, object: currentCellIdentifier)
        }
    }
    
    func selectCellStyle(at index: Int) {
        switch cellStyles[index] {
        case "GeoNews":
            currentCellIdentifier = NewsTableViewCell.identifier
        case "AppleNews":
            currentCellIdentifier = NewsTableViewCellAppleType.identifier
        case "BBCNews":
            currentCellIdentifier = NewsTableViewCellBBCType.identifier
        case "FastNews":
            currentCellIdentifier = NewsTableViewCellFastType.identifier
        case "CNNNews":
            currentCellIdentifier = NewsTableViewCellCNNType.identifier
        default:
            break
        }
    }
}

extension Notification.Name {
    static var cellStyleChanged = Notification.Name("cellStyleChanged")
}
