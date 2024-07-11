//
//  UIImageViewExtension.swift
//  GeoNews
//
//  Created by M1 on 10.07.2024.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(with urlString: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.image = image
                }
            }
        }.resume()
    }
}
