//
//  OrderController.swift
//  Restaurant 2019.05
//
//  Created by Denis Bystruev on 03/06/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

final class OrderController {
    var order = Order()
    
    static let shared = OrderController()
    
    private init() {}
}
