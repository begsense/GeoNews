//
//  NewsView.swift
//  GeoNews
//
//  Created by M1 on 02.07.2024.
//

import UIKit

class NewsView: UIViewController {
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    private var menuView = MenuView()
    private var politicNews = PoliticNewsView()
    private lazy var sportNews = SportNewsView()
    private lazy var healthNews = HealthNewsView()
    private lazy var techNews = TechNewsView()
    
    private var navView: UINavigationController?
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViews()
    }
    
    private func addChildViews() {
        menuView.delegate = self
        addChild(menuView)
        view.addSubview(menuView.view)
        menuView.didMove(toParent: self)
        
        politicNews.delegate = self
        let navView = UINavigationController(rootViewController: politicNews)
        addChild(navView)
        view.addSubview(navView.view)
        navView.didMove(toParent: self)
        self.navView = navView
        
    }
    
}

extension NewsView: PoliticNewsViewDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> ())?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navView?.view.frame.origin.x = self.politicNews.view.frame.size.width - 150
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }

        case . opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navView?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}

extension NewsView: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuView.menuOptions) {
        toggleMenu(completion: nil)
        switch menuItem {
        case .politics:
            self.resetPoliticsView()
        case .sports:
            self.addSportNewsView()
        case .health:
            self.addHealthNewsView()
        case .tech:
            self.addTechNewsView()
        }
    }
    
    private func addSportNewsView() {
        removeAllChildViews()
        politicNews.addChild(sportNews)
        politicNews.view.addSubview(sportNews.view)
        sportNews.view.frame = view.frame
        sportNews.didMove(toParent: politicNews)
        politicNews.title = sportNews.title
    }
    
    private func addHealthNewsView() {
        removeAllChildViews()
        politicNews.addChild(healthNews)
        politicNews.view.addSubview(healthNews.view)
        healthNews.view.frame = view.frame
        healthNews.didMove(toParent: politicNews)
        politicNews.title = healthNews.title
    }
    
    private func addTechNewsView() {
        removeAllChildViews()
        politicNews.addChild(techNews)
        politicNews.view.addSubview(techNews.view)
        techNews.view.frame = view.frame
        techNews.didMove(toParent: politicNews)
        politicNews.title = techNews.title
    }
    
    private func resetPoliticsView() {
        removeAllChildViews()
        politicNews.title = "Politics"
    }
    
    private func removeAllChildViews() {
        for child in politicNews.children {
            child.view.removeFromSuperview()
            child.didMove(toParent: nil)
        }
    }
}
