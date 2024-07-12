//
//  SportNewsDetailedView.swift
//  GeoNews
//
//  Created by M1 on 12.07.2024.
//

import UIKit

class SportNewsDetailedView: UIViewController {
    
    private var detailedView = NewsDetailedView(viewModel: NewsDetailedViewModel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(detailedView)
        view.addSubview(detailedView.view)
        detailedView.didMove(toParent: self)
        
        detailedView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailedView.view.topAnchor.constraint(equalTo: view.topAnchor),
            detailedView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailedView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailedView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
