//
//  MainModuleRouter.swift
//  ViperCollection
//
//  Created on 17/06/2019.
//  Copyright © 2019 Zakirov. All rights reserved.
//

import UIKit

class MainModuleRouter {

    static func createModule() -> UIViewController {

        let viewController = MainModuleViewController()

        let presenter = MainModulePresenter()
        let interactor = MainModuleInteractor()
        let router = MainModuleRouter()

        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        return viewController

    }

}

extension MainModuleRouter: MainModulePresenterToRouterProtocol {

}
