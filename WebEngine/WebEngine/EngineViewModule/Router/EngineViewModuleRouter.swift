//
//  EngineViewModuleRouter.swift
//  WebEngine
//
//  Created on 28/06/2019.
//  Copyright © 2019 ZAR. All rights reserved.
//

import UIKit

class EngineViewModuleRouter {

    static func createModule() -> UIViewController {

        let viewController = EngineViewModuleViewController()

        let presenter = EngineViewModulePresenter()
        let interactor = EngineViewModuleInteractor()
        let router = EngineViewModuleRouter()
        let webEngine = EngineImplementation()

        viewController.webPresentation = webEngine
     
      
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.webEngine = webEngine
        
        webEngine.delegate = interactor as? EngineDelegate
        webEngine.presentationDelegate = viewController as? EnginePresentationDelegate
        

        return viewController

    }

}

extension EngineViewModuleRouter: EngineViewModulePresenterToRouterProtocol {

}
