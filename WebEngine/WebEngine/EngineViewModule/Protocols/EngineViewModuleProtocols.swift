//
//  EngineViewModuleProtocols.swift
//  WebEngine
//
//  Created on 28/06/2019.
//  Copyright © 2019 ZAR. All rights reserved.
//

protocol EngineViewModuleViewToPresenterProtocol: AnyObject {
    // MARK: define protocol
    func readyToShow()
    
}

protocol EngineViewModulePresenterToViewProtocol: AnyObject {
    // MARK: define protocol
    func show()
}

protocol EngineViewModulePresenterToRouterProtocol: AnyObject {
    // MARK: define protocol

}

protocol EngineViewModulePresenterToInteractorProtocol: AnyObject {
    // MARK: define protocol
    func start()
    func finish()
}

protocol EngineViewModuleInteractorToPresenterProtocol: AnyObject {
    // MARK: define protocol
    func present()
    
}

// MARK: EngineViewModule Assembly protocols

protocol EngineViewModuleViewAssemblyProtocol: AnyObject {
    var presenter: EngineViewModuleViewToPresenterProtocol? {get set}
    var webPresentation: EnginePresentation? { get set }

}

protocol EngineViewModulePresenterAssemblyProtocol: AnyObject {
    var viewController: EngineViewModulePresenterToViewProtocol? {get set}
    var interactor: EngineViewModulePresenterToInteractorProtocol? {get set}
    var router: EngineViewModulePresenterToRouterProtocol? {get set}
}

protocol EngineViewModuleInteractorAssemblyProtocol: AnyObject {
    var presenter: EngineViewModuleInteractorToPresenterProtocol? {get set}
    var webEngine: EngineFile? { get set }
}

protocol EngineViewAssemblyProtocol: AnyObject {
    var delegate: EngineDelegate? { get set }
    var presentationDelegate: EnginePresentationDelegate? { get set }
}


