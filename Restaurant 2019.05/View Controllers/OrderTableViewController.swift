//
//  OrderTableViewController.swift
//  Restaurant 2019.05
//
//  Created by Denis Bystruev on 03/06/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    let cellController = CellController()
    var order: Order!
}

// MARK: - UITableViewDataSource
extension OrderTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell")!
        let menuItem = order.menuItems[indexPath.row]
        cellController.configure(cell, with: menuItem)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension OrderTableViewController {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            OrderController.shared.order.menuItems.remove(at: indexPath.row)
        }
    }
}

// MARK: - UIViewController
extension OrderTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        order = OrderController.shared.order
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        NotificationCenter.default.addObserver(
            tableView!,
            selector: #selector(UITableView.reloadData),
            name: Order.orderUpdateNotification,
            object: nil
        )
    }
}
