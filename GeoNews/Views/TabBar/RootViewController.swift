//
//  RootViewController.swift
//  GeoNews
//
//  Created by M1 on 28.06.2024.
//

import UIKit
import SwiftUI

class RootViewController: UIViewController {
    var profileViewModel: ProfileViewModel!
    var generalNewsViewModel: GeneralNewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModels()
        setUpTabBar()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setUpViewModels() {
        profileViewModel = ProfileViewModel()
        generalNewsViewModel = GeneralNewsViewModel(profileViewModel: profileViewModel)
    }
    
    func setUpTabBar() {
        let tabBarController = UITabBarController()
        let newsView =  NewsView()  //GeneralNewsView(viewModel: generalNewsViewModel)
        let quizView = UIHostingController(rootView: QuizView())
        let leaderboardsView = LeaderboardsView()
        let profileHostingController = UIHostingController(rootView: ProfileView().environmentObject(profileViewModel))
        
        tabBarController.viewControllers = [
            newsView,
            quizView,
            leaderboardsView,
            profileHostingController
        ]
        
        newsView.tabBarItem = UITabBarItem(title: "News", image: UIImage(named: "paperplane"), tag: 0)
        quizView.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(named: "quiz"), tag: 1)
        leaderboardsView.tabBarItem = UITabBarItem(title: "Leaderboard", image: UIImage(named: "leaderboard"), tag: 2)
        profileHostingController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "sun.max"), tag: 3)
        
        tabBarController.tabBar.barTintColor = UIColor(red: 0/255, green: 64/255, blue: 99/255, alpha: 1)
        tabBarController.tabBar.tintColor = .white
        
        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
    }
}
