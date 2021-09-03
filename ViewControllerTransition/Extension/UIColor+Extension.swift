//
//  UIColor+Extension.swift
//  ViewControllerTransition
//
//  Created by fuyoufang on 2021/9/2.
//

import UIKit

extension UIColor {
    
    
    /// 返回随机颜色
    open class var random: UIColor {
        let red = CGFloat(arc4random() % 256) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
