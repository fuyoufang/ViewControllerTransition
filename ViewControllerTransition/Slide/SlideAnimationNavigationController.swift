//
//  SlideAnimationNavigationController.swift
//  ViewControllerTransition
//
//  Created by fuyoufang on 2021/9/2.
//

import UIKit

class SlideAnimationNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
}

extension SlideAnimationNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return SlideAnimationController(type: .navigation(operation))
    }
}
