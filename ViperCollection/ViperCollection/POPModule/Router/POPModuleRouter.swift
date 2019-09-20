//
//  POPModuleRouter.swift
//  ViperCollection
//
//  Created on 27/06/2019.
//  Copyright © 2019 Zakirov. All rights reserved.
//

import UIKit

class POPModuleRouter {

    static func createModule() -> UIViewController {

        let viewController = POPModuleViewController()

        let presenter = POPModulePresenter()
        let interactor = POPModuleInteractor()
        let router = POPModuleRouter()

        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        return viewController

    }

}

extension POPModuleRouter: POPModulePresenterToRouterProtocol {

}
