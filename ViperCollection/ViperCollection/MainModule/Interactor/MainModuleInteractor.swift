//
//  MainModuleInteractor.swift
//  ViperCollection
//
//  Created on 17/06/2019.
//  Copyright © 2019 Zakirov. All rights reserved.
//
import UIKit
class MainModuleInteractor: MainModuleInteractorAssemblyProtocol {
    weak var presenter: MainModuleInteractorToPresenterProtocol?

    struct Fruit {
        let title: String
        let tag: String
        let image: UIImage
    }
    
}

extension MainModuleInteractor: MainModulePresenterToInteractorProtocol {

}
