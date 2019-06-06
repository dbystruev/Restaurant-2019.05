//
//  OrderTableViewController.swift
//  Restaurant 2019.05
//
//  Created by Denis Bystruev on 03/06/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    @IBOutlet weak var submitButton: UIBarButtonItem!
    
    let cellController = CellController()
    let menuController = MenuController()
    var order: Order!
    var orderMinutes = 0
    var orderTotal: Double {
        return order.menuItems.reduce(0) { $0 + $1.price }
    }
}

// MARK: - Navigation
extension OrderTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "OrderConfirmationSegue" else { return }
        let destination = segue.destination as! OrderConfirmationViewController
        destination.minutes = orderMinutes
    }
    
    @IBAction func submitButtonTapped(_ sender: UITabBarItem) {
        let formattedOrder = String(format: "$%.2f", orderTotal)
        let alert = UIAlertController(
            title: "Confirm Order",
            message: "You are about to submit your order with a total of \(formattedOrder)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Confirm", style: .default) { _ in
            self.uploadOrder()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
        guard segue.identifier == "DismissConfirmation" else { return }
        order.menuItems.removeAll()
    }
}

// MARK: - Order Management
extension OrderTableViewController {
    func uploadOrder() {
        tabBarItem.isEnabled = false
        let menuIds = order.menuItems.map { $0.id }
        menuController.submitOrder(forMenuIDs: menuIds) { minutes in
            guard let minutes = minutes else {
                print(Date(), #line, #function, "Can't submit the order")
                return
            }
            self.orderMinutes = minutes
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "OrderConfirmationSegue", sender: nil)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension OrderTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
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
        tabBarItem.isEnabled = 0 < orderTotal
        
        NotificationCenter.default.addObserver(
            tableView!,
            selector: #selector(UITableView.reloadData),
            name: Order.orderUpdateNotification,
            object: nil
        )
    }
}
