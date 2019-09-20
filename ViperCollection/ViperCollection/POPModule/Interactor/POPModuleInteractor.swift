//
//  POPModuleInteractor.swift
//  ViperCollection
//
//  Created on 27/06/2019.
//  Copyright © 2019 Zakirov. All rights reserved.
//

class POPModuleInteractor: POPModuleInteractorAssemblyProtocol {
    weak var presenter: POPModuleInteractorToPresenterProtocol?

}

extension POPModuleInteractor: POPModulePresenterToInteractorProtocol {

}
