//
//  POPModulePresenter.swift
//  ViperCollection
//
//  Created on 27/06/2019.
//  Copyright © 2019 Zakirov. All rights reserved.
//

class POPModulePresenter: POPModulePresenterAssemblyProtocol {

    weak var viewController: POPModulePresenterToViewProtocol?
    var interactor: POPModulePresenterToInteractorProtocol?
    var router: POPModulePresenterToRouterProtocol?

}

extension POPModulePresenter: POPModuleViewToPresenterProtocol {

}

extension POPModulePresenter: POPModuleInteractorToPresenterProtocol {

}
