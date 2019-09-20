//
//  EngineViewModulePresenter.swift
//  WebEngine
//
//  Created on 28/06/2019.
//  Copyright © 2019 ZAR. All rights reserved.
//

class EngineViewModulePresenter: EngineViewModulePresenterAssemblyProtocol {

    weak var viewController: EngineViewModulePresenterToViewProtocol?
    var interactor: EngineViewModulePresenterToInteractorProtocol?
    var router: EngineViewModulePresenterToRouterProtocol?

}

extension EngineViewModulePresenter: EngineViewModuleViewToPresenterProtocol {
    func readyToShow() {
        interactor?.start()
    }
    

}

extension EngineViewModulePresenter: EngineViewModuleInteractorToPresenterProtocol {
    func present() {
        viewController?.show()
    }
    

}
