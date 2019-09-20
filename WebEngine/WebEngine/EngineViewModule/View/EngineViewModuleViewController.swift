//
//  EngineViewModuleViewController.swift
//  WebEngine
//
//  Created on 28/06/2019.
//  Copyright © 2019 ZAR. All rights reserved.
//

import UIKit

class EngineViewModuleViewController: UIViewController, EngineViewModuleViewAssemblyProtocol {
    var webPresentation: EnginePresentation?{
        didSet {
            webView.webPresentation = webPresentation
        }
    }
    

    var presenter: EngineViewModuleViewToPresenterProtocol?
    var webView = WebView()
    
    

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        navigationController?.isNavigationBarHidden = false
        presenter?.readyToShow()
    }

}

extension EngineViewModuleViewController: EngineViewModulePresenterToViewProtocol {
    func show() {
        setupWeb()
        setupBar()
    }
}

extension EngineViewModuleViewController{
    private func setupWeb(){
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    private func setupBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: webView.webViewToolbar)
    }
}
