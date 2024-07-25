//
//  NewsView.swift
//  GeoNews
//
//  Created by M1 on 02.07.2024.
//

import UIKit

class NewsView: UIViewController {
    //MARK: - Properties
    enum MenuState {
        case opened
        case closed
    }
    
    private var newsTitle: UILabel = {
        let label = UILabel()
        label.text = "All News"
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Regular", size: 16)
        return label
    }()
    
    private var menuState: MenuState = .closed
    
    private var menuView = MenuView(viewModel: MenuViewModel())
    
    private var generalNews = GeneralNewsView(viewModel: GeneralNewsViewModel())
    
    private var politicNews = PoliticNewsView(viewModel: PoliticsNewsViewModel())
    
    private var sportNews = SportNewsView(viewModel: SportNewsViewModel())
    
    private var healthNews = HealthNewsView(viewModel: HealthNewsViewModel())
    
    private var techNews = TechNewsView(viewModel: TechNewsViewModel())
    
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

//MARK: - Extensions
extension NewsView: GeneralNewsViewDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> ())?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navView?.view.frame.origin.x = self.generalNews.view.frame.size.width/2
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
        generalNews.navigationItem.titleView = politicNews.navigationItem.titleView
    }
    
    private func addSportNewsView() {
        removeAllChildViews()
        generalNews.addChild(sportNews)
        generalNews.view.addSubview(sportNews.view)
        sportNews.view.frame = view.frame
        sportNews.didMove(toParent: generalNews)
        generalNews.navigationItem.titleView = sportNews.navigationItem.titleView
    }
    
    private func addHealthNewsView() {
        removeAllChildViews()
        generalNews.addChild(healthNews)
        generalNews.view.addSubview(healthNews.view)
        healthNews.view.frame = view.frame
        healthNews.didMove(toParent: generalNews)
        generalNews.navigationItem.titleView = healthNews.navigationItem.titleView
    }
    
    private func addTechNewsView() {
        removeAllChildViews()
        generalNews.addChild(techNews)
        generalNews.view.addSubview(techNews.view)
        techNews.view.frame = view.frame
        techNews.didMove(toParent: generalNews)
        generalNews.navigationItem.titleView = techNews.navigationItem.titleView
    }
    
    private func resetGeneralNewsView() {
        removeAllChildViews()
        generalNews.navigationItem.titleView = newsTitle
    }
    
    private func removeAllChildViews() {
        generalNews.children.forEach {
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
    }
}
