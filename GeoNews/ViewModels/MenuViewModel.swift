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
    var updateUserLabel: ((String) -> Void)?
    
    func fetchUserData() {
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if error != nil {
                  return
            }
            if let user = user {
                self.updateUserLabel?(" \(user.username)\n Score: \(user.score)")
            }
        }
    }
    
    func logout(completion: @escaping (Error?) -> Void) {
        AuthService.shared.signOut { error in
            completion(error)
        }
    }
    
    
}
