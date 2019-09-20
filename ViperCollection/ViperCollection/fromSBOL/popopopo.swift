//
//  popopopo.swift
//  ViperCollection
//
//  Created by Artem Zakirov on 27/06/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

import UIKit

class PopupTransitioningManager: NSObject {
    var presentationStyle: PopupStyle = .none
}

extension PopupTransitioningManager: UIViewControllerTransitioningDelegate {
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
        ) -> UIPresentationController? {
        let presentationController = PopupPresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.style = presentationStyle
        
        return presentationController
    }
}
