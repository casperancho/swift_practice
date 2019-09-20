//
//  NavigationBar.swift
//  WebEngine
//
//  Created by 17515726 on 28/06/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//
import UIKit
import SnapKit
import WebKit

class NavigationToolbar: UIView{
    
    struct Appearance {
        static let finishButtonLabelText = "Готово"
        static let finishButtonLeftOffset = -5
        static let finishButtonTopOffset = -1
        
        static let backButtonLeftOffset = 24
        static let forwardButtonLeftOffset = 24
        static let refreshButtonLeftOffset = 24
        static let width = 240
        static let height = 50
        static let controlsSize = 24
        static let buttonColor = UIColor.green
    }
    
    lazy var backButton = UIButton(frame: .zero)
    lazy var forwardButton = UIButton(frame: .zero)
    private weak var webView: WKWebView?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(forWebView webView: WKWebView) {
        self.init(frame: CGRect.zero)
        
        self.webView = webView
        setupNavigationToolbar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NavigationToolbar {
    private func setupNavigationToolbar(){
        setupBackButton()
        setupForwardButton()
        
        snp.makeConstraints { make in
            make.width.equalTo(Appearance.width)
            make.height.equalTo(Appearance.height)
        }
    }
    
    private func setupBackButton(){
        backButton = UIButton(type: .contactAdd)
        backButton.tintColor = Appearance.buttonColor
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Appearance.backButtonLeftOffset)
            make.size.equalTo(Appearance.controlsSize)
            make.centerY.equalToSuperview()
        }
        backButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
    }
    
    private func setupForwardButton(){
        forwardButton = UIButton(type: .contactAdd)
        forwardButton.tintColor = Appearance.buttonColor
        addSubview(forwardButton)
        forwardButton.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right).offset(Appearance.forwardButtonLeftOffset)
            make.size.equalTo(Appearance.controlsSize)
            make.centerY.equalToSuperview()
        }
        forwardButton.addTarget(self, action: #selector(goForward(_:)), for: .touchUpInside)
    }
    
    @objc func goBack (_ sender: UIButton){
        self.webView?.goBack()
    }
    @objc func goForward (_ sender: UIButton){
        self.webView?.goForward()
    }
}

