//
//  POPModuleViewController.swift
//  ViperCollection
//
//  Created on 27/06/2019.
//  Copyright © 2019 Zakirov. All rights reserved.
//

import UIKit

class POPModuleViewController: UIViewController, POPModuleViewAssemblyProtocol {

    var presenter: POPModuleViewToPresenterProtocol?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension POPModuleViewController: POPModulePresenterToViewProtocol {

}
