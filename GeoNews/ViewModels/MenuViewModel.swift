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
    
    var updateUserName: ((String) -> Void)?
    
    var updateUserEmail: ((String) -> Void)?
    
    var logoutSuccess: (() -> Void)?
    
    var logoutFailure: ((Error?) -> Void)?
    
    func fetchUserData() {
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                return
            }
            if let user = user {
                self.updateUserName?("Hello, \n\(user.username)")
                self.updateUserEmail?(user.email)
            }
        }
    }
    
    func logout() {
        AuthService.shared.signOut { [weak self] error in
            if let error = error {
                self?.logoutFailure?(error)
            } else {
                self?.logoutSuccess?()
            }
        }
    }
}
