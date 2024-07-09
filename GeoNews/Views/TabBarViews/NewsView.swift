//
//  NewsView.swift
//  GeoNews
//
//  Created by M1 on 02.07.2024.
//

import UIKit

class NewsView: UIViewController {
    
    private var menuView = MenuView()
    private var politicNews = PoliticNewsView()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViews()

    }
    
    private func addChildViews() {
        addChild(menuView)
        view.addSubview(menuView.view)
        menuView.didMove(toParent: self)
        
        politicNews.delegate = self
        let navView = UINavigationController(rootViewController: politicNews)
        addChild(navView)
        view.addSubview(navView.view)
        politicNews.didMove(toParent: self)
        
    }
    
}

extension NewsView: PoliticNewsViewDelegate {
    func didTapMenuButton() {
        print("deeqliqa?? ah")
    }
}
