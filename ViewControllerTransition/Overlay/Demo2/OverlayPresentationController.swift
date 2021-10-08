//
//  OverlayPresentationController.swift
//  ViewControllerTransition
//
//  Created by fuyoufang on 2021/9/3.
//

import UIKit
import Then

class OverlayPresentationController: UIPresentationController {
    
    let dimmingView = UIView().then {
        $0.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        $0.alpha = 0
        UINavigationControllerDelegate
    }
    
    // Presentation 转场开始前该方法被调用。
    override func presentationTransitionWillBegin() {
        self.containerView?.addSubview(dimmingView)
        dimmingView.frame = containerView!.bounds
        
        //使用 transitionCoordinator 与转场动画并行执行 dimmingView 的动画。
        presentedViewController.transitionCoordinator?
            .animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 1

            }, completion: nil)
        
    }
    
    // Dismissal 转场开始前该方法被调用。添加了 dimmingView 消失的动画，在上一节中并没有添加这个动画，
    // 实际上由于 presentedView 的形变动画，这个动画根本不会被注意到，此处只为示范。
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?
            .animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 0.0
            }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        debugPrint("containerViewWillLayoutSubviews")
    }
}
