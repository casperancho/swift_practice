//
//  MainModulePresenter.swift
//  ViperCollection
//
//  Created on 17/06/2019.
//  Copyright © 2019 Zakirov. All rights reserved.
//

class MainModulePresenter: MainModulePresenterAssemblyProtocol {

    weak var viewController: MainModulePresenterToViewProtocol?
    var interactor: MainModulePresenterToInteractorProtocol?
    var router: MainModulePresenterToRouterProtocol?

}

extension MainModulePresenter: MainModuleViewToPresenterProtocol {

}

extension MainModulePresenter: MainModuleInteractorToPresenterProtocol {
    func presentItems() {
        viewController?.showItem()
    }
    

}
