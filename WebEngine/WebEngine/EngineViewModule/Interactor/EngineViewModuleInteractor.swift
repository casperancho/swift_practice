//
//  EngineViewModuleInteractor.swift
//  WebEngine
//
//  Created on 28/06/2019.
//  Copyright © 2019 ZAR. All rights reserved.
//

class EngineViewModuleInteractor: EngineViewModuleInteractorAssemblyProtocol {
    var webEngine: EngineFile?
    
    weak var presenter: EngineViewModuleInteractorToPresenterProtocol?

}

extension EngineViewModuleInteractor: EngineViewModulePresenterToInteractorProtocol {
    func start() {
        let htmlString = "<html><body><br><br><br><br><br><br><h1><a href= https://yandex.ru>                  hello</h1></body><html>"
        presenter?.present()
        webEngine?.load(htmlString: htmlString)
    }
    
    func finish() {
        
    }
    

}

