//
//  WebViewer.swift
//  GeoNews
//
//  Created by M1 on 02.07.2024.
//

import UIKit
import WebKit

class WebViewer: UIViewController {
    
    private let webView = WKWebView()
    private let urlString: String
    
    init(with urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        guard let url = URL(string: urlString) else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        webView.load(URLRequest(url: url))
        
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc private func didTapDone() {
        dismiss(animated: true, completion: nil)
    }
}
