//
//  EngineFile.swift
//  WebEngine
//
//  Created by 17515726 on 28/06/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

import Foundation
import WebKit

protocol EngineFile: AnyObject {
    func load(htmlString: String)
}

protocol EnginePresentation: AnyObject {
    func setup(with webWiew: WKWebView)
}

protocol EnginePresentationDelegate: AnyObject{
    func present(alert: UIAlertController)
    func didStartLoading()
    func didFinishLoading()
}

protocol EngineDelegate: AnyObject {
    func willNavigate(to url: URL?)
}
