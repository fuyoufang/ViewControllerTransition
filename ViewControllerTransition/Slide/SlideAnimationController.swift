//
//  SlideAnimationController.swift
//  ViewControllerTransition
//
//  Created by fuyoufang on 2021/9/2.
//

import UIKit

class SlideAnimationController: NSObject {
    
    let type: TransitionType
    
    init(type: TransitionType) {
        self.type = type
        super.init()
    }
    
    
    
}

extension SlideAnimationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)

        if let toView = toView {
            containerView.addSubview(toView)
        }
        
        let toViewStartTransform: CGAffineTransform
        let fromViewEndTransform: CGAffineTransform
        
        switch type {
        case let .navigation(operation):
            switch operation {
            case .pop:
                toViewStartTransform = CGAffineTransform(translationX: -UIScreen.main.bounds.size.width, y: 0)
                fromViewEndTransform = CGAffineTransform(translationX: UIScreen.main.bounds.size.width, y: 0)
            case .push:
                toViewStartTransform = CGAffineTransform(translationX: UIScreen.main.bounds.size.width, y: 0)
                fromViewEndTransform = CGAffineTransform(translationX: -UIScreen.main.bounds.size.width, y: 0)
            default:
                toViewStartTransform = .identity
                fromViewEndTransform = .identity
            }
            
        default:
            toViewStartTransform = .identity
            fromViewEndTransform = .identity
        }
        
        
        
        toView?.transform = toViewStartTransform
        UIView.animate(withDuration: duration) {
            fromView?.transform = fromViewEndTransform
            toView?.transform = .identity
        } completion: { _ in
            fromView?.transform = .identity
            toView?.transform = .identity
            
            let isCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!isCancelled)
            
        }

        
        
    }
    
}
