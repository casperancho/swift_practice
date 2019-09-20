//
//  webView.swift
//  WebEngine
//
//  Created by 17515726 on 28/06/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebView : UIView {
    var webPresentation: EnginePresentation? {
        didSet {
            guard let webPresentation = webPresentation else { return }
            webPresentation.setup(with: webView)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupWebView()
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    private lazy var webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    lazy var webViewToolbar = NavigationToolbar(forWebView: webView)
}

extension WebView {
    private func setupWebView() {
        addSubview(webView)
        webView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }

    }
}

