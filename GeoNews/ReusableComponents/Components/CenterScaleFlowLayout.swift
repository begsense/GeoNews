//
//  CenterScaleFlowLayout.swift
//  GeoNews
//
//  Created by M1 on 21.07.2024.
//

import UIKit

class CenterScaleFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        let center = collectionView!.bounds.size.width / 2 + collectionView!.contentOffset.x
        
        for attribute in attributes {
            let distance = abs(attribute.center.x - center)
            let scale = max(1 - distance / center, 0.7)
            attribute.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
