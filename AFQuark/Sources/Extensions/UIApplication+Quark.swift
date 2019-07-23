//
//  UIApplication+Quark.swift
//  AFQuark
//
//  Created by Laurent Favard on 23/07/2019.
//  Copyright © 2019 Laurent Favard. All rights reserved.
//

import UIKit

/*
 Usage:
 
 if let topController = UIApplication.topViewController() {
 print("The view controller you're looking at is: \(topController)")
 }
 */


public extension AFBase where Base:  UIApplication {
    
    static func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
