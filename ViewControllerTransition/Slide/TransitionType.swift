//
//  TransitionType.swift
//  ViewControllerTransition
//
//  Created by fuyoufang on 2021/9/2.
//

import UIKit

enum TransitionType {
    // UINavigationController.Operation 是枚举类型，有 none, push, pop 三种值。
    case navigation(UINavigationController.Operation)
    case tab(TabOperationDirection)
    case modal(ModalOperation)
}

enum TabOperationDirection {
    case Left, Right
}
enum ModalOperation {
    case Presentation, Dismissal
}
