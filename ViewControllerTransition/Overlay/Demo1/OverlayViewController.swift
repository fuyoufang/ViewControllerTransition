//
//  CenterViewController.swift
//  ViewControllerTransition
//
//  Created by fuyoufang on 2021/9/2.
//

import Foundation
import UIKit
import Then
import SnapKit


class OverlayViewController: UIViewController {
    
    // MARK: Properties
    lazy var overlayAnimationController = OverlayAnimationController()
    
    // MARK: UI
    let closeButton = UIButton().then {
        $0.setTitle("关闭", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.backgroundColor = .orange
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setupSubviews() {
        view.addSubview(closeButton)
        
        closeButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
    }
    
    
    override var preferredContentSize: CGSize {
        get {
            return CGSize(width: 400, height: 400)
        }
        set {
            
        }
    }
}

extension OverlayViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return overlayAnimationController
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return overlayAnimationController
    }
}
