//
//  AppDelegate.swift
//  Restaurant 2019.05
//
//  Created by Denis Bystruev on 27/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var orderTabBarItem: UITabBarItem!
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateOrderBadge),
            name: Order.orderUpdateNotification,
            object: nil
        )
        
        let tabBarController = window!.rootViewController! as! UITabBarController
        orderTabBarItem = tabBarController.viewControllers![1].tabBarItem
        
        return true
    }
    
    @objc func updateOrderBadge() {
        let count = OrderController.shared.order.menuItems.count
        switch count {
        case 0:
            orderTabBarItem.badgeValue = nil
        default:
            orderTabBarItem.badgeValue = "\(count)"
        }
    }
}

