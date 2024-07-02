//
//  SceneDelegate.swift
//  GeoNews
//
//  Created by M1 on 27.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
       // let viewModel = MainPageViewModel()
        let navigationController = UINavigationController(rootViewController: SignInView())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}
