//
//  MainModuleProtocols.swift
//  ViperCollection
//
//  Created on 17/06/2019.
//  Copyright © 2019 Zakirov. All rights reserved.
//

protocol MainModuleViewToPresenterProtocol: AnyObject {
    // MARK: define protocol

}

protocol MainModulePresenterToViewProtocol: AnyObject {
    // MARK: define protocol
    func showItem()
}

protocol MainModulePresenterToRouterProtocol: AnyObject {
    // MARK: define protocol

}

protocol MainModulePresenterToInteractorProtocol: AnyObject {
    // MARK: define protocol

}

protocol MainModuleInteractorToPresenterProtocol: AnyObject {
    // MARK: define protocol
    func presentItems()
}

// MARK: MainModule Assembly protocols

protocol MainModuleViewAssemblyProtocol: AnyObject {
    var presenter: MainModuleViewToPresenterProtocol? {get set}
}

protocol MainModulePresenterAssemblyProtocol: AnyObject {
    var viewController: MainModulePresenterToViewProtocol? {get set}
    var interactor: MainModulePresenterToInteractorProtocol? {get set}
    var router: MainModulePresenterToRouterProtocol? {get set}
}

protocol MainModuleInteractorAssemblyProtocol: AnyObject {
    var presenter: MainModuleInteractorToPresenterProtocol? {get set}
}
