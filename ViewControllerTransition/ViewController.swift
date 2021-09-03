//
//  ViewController.swift
//  ViewControllerTransition
//
//  Created by fuyoufang on 2021/8/28.
//

import UIKit
import Then

struct ActionItem {
    var title: String
    var action: () -> Void
}


class ViewController: UITableViewController {

    lazy var actionItems: [ActionItem] =
        [
            ActionItem(title: "侧滑 Slide", action: { [weak self] in
                let viewController = SlideAnimationViewController()
                let navigationController = SlideAnimationNavigationController(rootViewController: viewController)
                
                self?.show(navigationController, sender: nil)
            }),
            ActionItem(title: "中心 Center", action: { [weak self] in
                let viewController = OverlayViewController()
                    .then {
                        $0.modalPresentationStyle = .custom
                    }
                self?.present(viewController, animated: true, completion: nil)
            }),
            ActionItem(title: "中心2 Center ", action: { [weak self] in
                let viewController = OverlayWithPresentationViewController()
                    .then {
                        $0.modalPresentationStyle = .custom
                    }
                self?.present(viewController, animated: true, completion: nil)
            }),
            ActionItem(title: "Slide", action: { [weak self] in
                let viewController = SlideAnimationViewController()
                let navigationController = SlideAnimationNavigationController(rootViewController: viewController)
                
                self?.show(navigationController, sender: nil)
            })
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell?.textLabel?.text = actionItems[indexPath.row].title
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        actionItems[indexPath.row].action()
    }
    
}

