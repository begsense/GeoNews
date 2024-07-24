//
//  FileManagerHelper.swift
//  GeoNews
//
//  Created by M1 on 19.07.2024.
//

import Foundation
import UIKit

class FileManagerHelper {
    static var shared = FileManagerHelper()
    
    private var fileManager = FileManager.default
    
    private var profileImageKey = "profileImage"
    
    private var documentsDirectory: URL? {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func saveProfileImage(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8),
              let documentsDirectory = documentsDirectory else { return }
        
        let filePath = documentsDirectory.appendingPathComponent(profileImageKey)
        fileManager.createFile(atPath: filePath.path, contents: data, attributes: nil)
    }
    
    func loadProfileImage() -> UIImage? {
        guard let documentsDirectory = documentsDirectory else { return nil }
        
        let filePath = documentsDirectory.appendingPathComponent(profileImageKey)
        guard let data = fileManager.contents(atPath: filePath.path) else { return nil }
        
        return UIImage(data: data)
    }
}
