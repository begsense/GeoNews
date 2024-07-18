//
//  RootViewController.swift
//  GeoNews
//
//  Created by M1 on 28.06.2024.
//

import UIKit
import SwiftUI

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupTabBar() {
        let tabBarController = UITabBarController()
        let newsView =  NewsView()  //GeneralNewsView(viewModel: generalNewsViewModel)
        let searchView = SearchView(viewModel: SearchViewModel())
        let quizView = UIHostingController(rootView: QuizView())
        let exchangeView = UIHostingController(rootView: ExchangeView(viewModel: ExchangeViewModel()))
        let profileView = UIHostingController(rootView: ProfileView())
        
        tabBarController.viewControllers = [
            newsView,
            searchView,
            quizView,
            exchangeView,
            profileView
        ]
        
        newsView.tabBarItem = UITabBarItem(title: "News", image: UIImage(named: "paperplane"), tag: 0)
        searchView.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        quizView.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(named: "quiz"), tag: 2)
        exchangeView.tabBarItem = UITabBarItem(title: "Exchange", image: UIImage(named: "exchange"), tag: 3)
        profileView.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "sun.max"), tag: 4)
        
        tabBarController.tabBar.barTintColor = UIColor(red: 0/255, green: 64/255, blue: 99/255, alpha: 1)
        tabBarController.tabBar.tintColor = .white
        
        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
    }
}
