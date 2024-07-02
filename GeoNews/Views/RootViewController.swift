//
//  RootViewController.swift
//  GeoNews
//
//  Created by M1 on 28.06.2024.
//

import UIKit

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    func setUpTabBar() {
        
        let tabBarController = UITabBarController()
        let newsView = NewsView()
        let quizView = QuizView()
        let leaderboardsView = LeaderboardsView()
        let profileView = ProfileView()
        
        tabBarController.viewControllers = [
            newsView,
            quizView,
            leaderboardsView,
            profileView
        ]
        
        newsView.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "aqi.high"), tag: 0)
        quizView.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(systemName: "cloud.sun"), tag: 1)
        leaderboardsView.tabBarItem = UITabBarItem(title: "Leaderboard", image: UIImage(systemName: "tortoise"), tag: 2)
        profileView.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "sun.max"), tag: 3)
        
        tabBarController.tabBar.barTintColor = .red
        tabBarController.tabBar.tintColor = UIColor(red: 231/255, green: 161/255, blue: 21/255, alpha: 1)
        
        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
    }
}



