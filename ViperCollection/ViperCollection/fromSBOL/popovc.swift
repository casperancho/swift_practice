//
//  popovc.swift
//  ViperCollection
//
//  Created by 17515726 on 27/06/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//
import UIKit

enum PopupStyle {
    case formSheetFromBottom
    case none
}

let MYblack = UIColor(displayP3Red: 0.0, green: 0.0, blue: 20.0/255.0, alpha: 1.0)


class PopupPresentationController: UIPresentationController {
    struct Appearance {
        static let formSheetViewCornerRadius: CGFloat = 16
        static let formSheetFromBottomOffset = UIOffset(horizontal: 80, vertical: 40)
        static let formSheetFromBottomSize = CGSize(width: 608, height: 984)
    }
    
    var style: PopupStyle = .none
    private var presentedViewWrapper: UIView?
    private var presentedViewContainer: UIView?
    private lazy var dimmingView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        setupDimmingView()
    }
    
    override var presentedView: UIView? {
        return presentedViewWrapper
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        switch style {
        case .formSheetFromBottom:
            return makeFormSheetFromBottomRect()
        case .none:
            return .zero
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        adjustPresentedViewAppearance()
    }
    
    override func presentationTransitionWillBegin() {
        let presentedViewControllerView = super.presentedView!
        wrapPresentedView(presentedViewControllerView)
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    private func wrapPresentedView(_ presentedViewControllerView: UIView) {
        let presentedViewWrapper = UIView(frame: frameOfPresentedViewInContainerView)
        let presentedViewContainer = UIView(frame: presentedViewWrapper.bounds)
        self.presentedViewWrapper = presentedViewWrapper
        self.presentedViewContainer = presentedViewContainer
        
        presentedViewContainer.addSubview(presentedViewControllerView)
        presentedViewControllerView.snp.makeConstraints { make in
            make.center.size.equalToSuperview()
        }
        
        presentedViewWrapper.addSubview(presentedViewContainer)
        presentedViewContainer.snp.makeConstraints { make in
            make.center.size.equalToSuperview()
        }
        
        containerView?.insertSubview(dimmingView, at: 0)
        dimmingView.snp.makeConstraints { make in
            make.center.size.equalToSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(
            alongsideTransition: { _ in
                self.dimmingView.alpha = 0.0
        }
        )
    }
    
    private func adjustPresentedViewAppearance() {
        switch style {
        case .formSheetFromBottom:
            presentedViewWrapper?.layer.applyShadow(color: MYblack, alpha: 0.15, blur: 20, spread: -8)
            
            presentedViewContainer?.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: Appearance.formSheetViewCornerRadius)
        case .none:
            break
        }
    }
    
    private func makeFormSheetFromBottomRect() -> CGRect {
        guard let containerView = containerView else { return .zero }
        let size = getPresentedViewSize(style: .formSheetFromBottom)
        let offset = getPresentedViewOffset(style: .formSheetFromBottom)
        let originX = containerView.bounds.origin.x + offset.horizontal
        let originY = containerView.bounds.height - size.height
        
        return CGRect(x: originX, y: originY, width: size.width, height: size.height)
    }
    
    private func getPresentedViewOffset(style: PopupStyle) -> UIOffset {
        switch style {
        case .formSheetFromBottom:
            return Appearance.formSheetFromBottomOffset
        case .none:
            return .zero
        }
    }
    
    private func getPresentedViewSize(style: PopupStyle) -> CGSize {
        switch style {
        case .formSheetFromBottom:
            return Appearance.formSheetFromBottomSize
        case .none:
            return .zero
        }
    }
    
    private func setupDimmingView() {
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.alpha = 0.0
    }
}



extension CALayer {
    func applyShadow(
        color: UIColor = MYblack,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 0,
        blur: CGFloat = 20,
        spread: CGFloat = 0,
        cornerRadius: CGFloat = 0
        ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur
        
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        }
    }
}


extension UIView {
    func roundCorners(_ corners: CACornerMask? = nil, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        
        if let corners = corners {
            layer.maskedCorners = corners
        }
    }
}
