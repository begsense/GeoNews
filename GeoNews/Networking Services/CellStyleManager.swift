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
    
    var cellStyles = ["StaticCell", "RedditType"]
    private var currentCellIdentifier: String = NewsTableViewCell.identifier {
        didSet {
            NotificationCenter.default.post(name: .cellStyleChanged, object: currentCellIdentifier)
        }
    }
    
    func selectCellStyle(at index: Int) {
        switch cellStyles[index] {
        case "StaticCell":
            currentCellIdentifier = NewsTableViewCell.identifier
        case "RedditType":
            currentCellIdentifier = NewsTableViewCellRedditType.identifier
        default:
            break
        }
    }
}

extension Notification.Name {
    static let cellStyleChanged = Notification.Name("cellStyleChanged")
}
