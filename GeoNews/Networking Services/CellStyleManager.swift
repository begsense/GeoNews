//
//  CellStyleManager.swift
//  GeoNews
//
//  Created by M1 on 20.07.2024.
//

import Foundation

class CellStyleManager {
    static let shared = CellStyleManager()
    
    private init() {}
    
    var cellStyles = ["GeoNews", "AppleNews"]
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
        default:
            break
        }
    }
}

extension Notification.Name {
    static let cellStyleChanged = Notification.Name("cellStyleChanged")
}
