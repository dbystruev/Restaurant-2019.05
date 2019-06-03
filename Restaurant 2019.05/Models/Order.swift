//
//  Order.swift
//  Restaurant 2019.05
//
//  Created by Denis Bystruev on 27/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

final class Order: Codable {
    var menuItems: [MenuItem] = [] {
        didSet {
            NotificationCenter.default.post(name: Order.orderUpdateNotification, object: nil)
        }
    }
    
    static let orderUpdateNotification = Notification.Name("Order.orderUpdated")
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
