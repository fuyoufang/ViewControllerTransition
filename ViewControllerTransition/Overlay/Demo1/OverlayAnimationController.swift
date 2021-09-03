//
//  OverlayAnimationController.swift
//  ViewControllerTransition
//
//  Created by fuyoufang on 2021/9/2.
//

import UIKit

class OverlayAnimationController: NSObject {
    
    let dimmingView = UIView().then {
        $0.backgroundColor = UIColor(white: 0.0, alpha: 0)
    }
    
    var transitionDuration: TimeInterval = 0.5
    
}

extension OverlayAnimationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: .to)!
        let fromVC = transitionContext.viewController(forKey: .from)!
        
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        
        let containerView = transitionContext.containerView
        
        let duration = transitionDuration(using: transitionContext)

        // 不像容器 VC 转场里需要额外的变量来标记操作类型，UIViewController 自身就有方法跟踪 Modal 状态。
        // 处理 Presentation 转场
        if toVC.isBeingPresented {
            let toViewStartTransform: CGAffineTransform = .init(scaleX: 0, y: 0)
            
            // 设置 presentedView 和 暗背景视图 dimmingView 的初始位置和尺寸。
            
            let toViewSize = toVC.preferredContentSize
            
            // 在 presentedView 后面添加暗背景视图 dimmingView，
            // 注意两者在 containerView 中的位置。
            
            dimmingView.frame = containerView.bounds
            // 1
            if let toView = toView {
                containerView.addSubview(toView)
                containerView.insertSubview(dimmingView, belowSubview: toView)
                toView.snp.makeConstraints {
                    $0.size.equalTo(toViewSize)
                    $0.center.equalToSuperview()
                    
                }
            }
            
            toView?.transform = toViewStartTransform
            
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: .curveEaseInOut) {
                toView?.transform = .identity
                self.dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
            } completion: { _ in
                // 2
                let isCancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!isCancelled)
            }
        }
        
        // 处理 Dismissal 转场，
        // .custom 模式下不要将 toView 添加到 containerView，省去了上面标记1处的操作。
        if fromVC.isBeingDismissed {
            guard let fromView = fromView else {
                let isCancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!isCancelled)
                return
            }
            fromView.transform = .identity
            let fromeViewEndTransform: CGAffineTransform = .init(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: duration, animations: {
                fromView.transform = fromeViewEndTransform
                self.dimmingView.alpha = 0
            }, completion: { _ in
                //2
                let isCancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!isCancelled)
            })
        }
    }
}
