//
//  MainModuleViewController.swift
//  WebEngine
//
//  Created on 28/06/2019.
//  Copyright © 2019 ZAR. All rights reserved.
//

import UIKit
import SnapKit
import WebKit


class MainModuleViewController: UINavigationController, MainModuleViewAssemblyProtocol {

    var presenter: MainModuleViewToPresenterProtocol?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        open()
    }
    
    func open(){
         let myVC = EngineViewModuleRouter.createModule()
        self.pushViewController(myVC, animated: true)
        presenter?.didTapOpenButton()
    }

}

extension MainModuleViewController: MainModulePresenterToViewProtocol {

}
