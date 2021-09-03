//
//  SlideAnimationViewController.swift
//  ViewControllerTransition
//
//  Created by fuyoufang on 2021/9/2.
//

import UIKit

class SlideAnimationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random
        title = "title:\(Int(arc4random() % 256))"
        
        let closeBarButton = UIBarButtonItem(systemItem: .close)
        closeBarButton.action = #selector(close)
        closeBarButton.target = self
        navigationItem.rightBarButtonItem = closeBarButton
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.pushViewController(SlideAnimationViewController(), animated: true)
    }
}

