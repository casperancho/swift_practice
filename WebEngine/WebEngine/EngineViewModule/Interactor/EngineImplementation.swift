//
//  EngineImplementation.swift
//  WebEngine
//
//  Created by 17515726 on 28/06/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

import UIKit
import WebKit

class EngineImplementation : NSObject, EngineViewAssemblyProtocol {
    var delegate: EngineDelegate?
    var presentationDelegate: EnginePresentationDelegate?
    private var webView: WKWebView?
    
}

extension EngineImplementation: EngineFile {
    func load(htmlString: String) {
        guard let webView = webView else {
            print("SBOLViewWebEngineImplementation:load: webView is uninitialized")
            return
        }
    
//        webView.load(URLRequest(url: URL(string: "https://yandex.ru")!))
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
}

extension EngineImplementation: EnginePresentation{
    func setup(with webWiew: WKWebView) {
        self.webView = webWiew
        webWiew.navigationDelegate = self as? WKNavigationDelegate
        webWiew.uiDelegate = self as? WKUIDelegate
        
        
        let userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0.2 Safari/605.1.15"
        webWiew.customUserAgent = userAgent
        webWiew.allowsBackForwardNavigationGestures = true

        
    }
    
    
}

extension EngineImplementation: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
        ) {
        decisionHandler(.allow)
    }
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url,
                let host = url.host, !host.hasPrefix("www.google.com"),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                print("Redirected to browser. No need to open it locally")
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        } else {
            decisionHandler(.allow)
        }
    }
}

extension EngineImplementation: WKUIDelegate{
    
}
