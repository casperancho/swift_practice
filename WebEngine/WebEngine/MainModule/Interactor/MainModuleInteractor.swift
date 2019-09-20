//
//  MainModuleInteractor.swift
//  WebEngine
//
//  Created on 28/06/2019.
//  Copyright © 2019 ZAR. All rights reserved.
//

class MainModuleInteractor: MainModuleInteractorAssemblyProtocol {
    weak var presenter: MainModuleInteractorToPresenterProtocol?

}

extension MainModuleInteractor: MainModulePresenterToInteractorProtocol {

}
