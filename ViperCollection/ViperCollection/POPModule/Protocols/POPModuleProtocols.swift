//
//  POPModuleProtocols.swift
//  ViperCollection
//
//  Created on 27/06/2019.
//  Copyright © 2019 Zakirov. All rights reserved.
//

protocol POPModuleViewToPresenterProtocol: AnyObject {
    // MARK: define protocol

}

protocol POPModulePresenterToViewProtocol: AnyObject {
    // MARK: define protocol

}

protocol POPModulePresenterToRouterProtocol: AnyObject {
    // MARK: define protocol

}

protocol POPModulePresenterToInteractorProtocol: AnyObject {
    // MARK: define protocol

}

protocol POPModuleInteractorToPresenterProtocol: AnyObject {
    // MARK: define protocol

}

// MARK: POPModule Assembly protocols

protocol POPModuleViewAssemblyProtocol: AnyObject {
    var presenter: POPModuleViewToPresenterProtocol? {get set}
}

protocol POPModulePresenterAssemblyProtocol: AnyObject {
    var viewController: POPModulePresenterToViewProtocol? {get set}
    var interactor: POPModulePresenterToInteractorProtocol? {get set}
    var router: POPModulePresenterToRouterProtocol? {get set}
}

protocol POPModuleInteractorAssemblyProtocol: AnyObject {
    var presenter: POPModuleInteractorToPresenterProtocol? {get set}
}
