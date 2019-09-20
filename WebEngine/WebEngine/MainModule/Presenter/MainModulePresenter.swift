//
//  MainModulePresenter.swift
//  WebEngine
//
//  Created on 28/06/2019.
//  Copyright © 2019 ZAR. All rights reserved.
//

class MainModulePresenter: MainModulePresenterAssemblyProtocol {

    weak var viewController: MainModulePresenterToViewProtocol?
    var interactor: MainModulePresenterToInteractorProtocol?
    var router: MainModulePresenterToRouterProtocol?

}

extension MainModulePresenter: MainModuleViewToPresenterProtocol {
    func didTapOpenButton() {
        router?.openWebFromRouter()
    }
    

}

extension MainModulePresenter: MainModuleInteractorToPresenterProtocol {

}
