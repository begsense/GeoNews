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
    private var generalNews = GeneralNewsView()
    private lazy var politicNews = PoliticNewsView()
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

        generalNews.delegate = self
        let navView = UINavigationController(rootViewController: generalNews)
        addChild(navView)
        view.addSubview(navView.view)
        navView.didMove(toParent: self)
        self.navView = navView
    }
}

extension NewsView: GeneralNewsViewDelegate {
    
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> ())?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navView?.view.frame.origin.x = self.generalNews.view.frame.size.width - 150
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
        case .general:
            resetGeneralNewsView()
        case .politics:
            addPoliticNewsView()
        case .sports:
            addSportNewsView()
        case .health:
            addHealthNewsView()
        case .tech:
            addTechNewsView()
        }
    }
    
    private func addPoliticNewsView() {
        removeAllChildViews()
        generalNews.addChild(politicNews)
        generalNews.view.addSubview(politicNews.view)
        politicNews.view.frame = view.frame
        politicNews.didMove(toParent: generalNews)
        generalNews.title = politicNews.title
    }
    
    private func addSportNewsView() {
        removeAllChildViews()
        generalNews.addChild(sportNews)
        generalNews.view.addSubview(sportNews.view)
        sportNews.view.frame = view.frame
        sportNews.didMove(toParent: generalNews)
        generalNews.title = sportNews.title
    }
    
    private func addHealthNewsView() {
        removeAllChildViews()
        generalNews.addChild(healthNews)
        generalNews.view.addSubview(healthNews.view)
        healthNews.view.frame = view.frame
        healthNews.didMove(toParent: generalNews)
        generalNews.title = healthNews.title
    }
    
    private func addTechNewsView() {
        removeAllChildViews()
        generalNews.addChild(techNews)
        generalNews.view.addSubview(techNews.view)
        techNews.view.frame = view.frame
        techNews.didMove(toParent: generalNews)
        generalNews.title = techNews.title
    }
    
    private func resetGeneralNewsView() {
        removeAllChildViews()
        generalNews.title = "All News"
    }
    
    private func removeAllChildViews() {
        generalNews.children.forEach {
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
    }
}
