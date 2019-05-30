//
//  MenuTableViewController.swift
//  Restaurant 2019.05
//
//  Created by Denis Bystruev on 27/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    // MARK: Properties
    let cellController = CellController()
    let menuController = MenuController()
    var category: String!
    var menuItems = [MenuItem]()
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = category?.capitalized
        
        menuController.fetchMenuItems(forCategory: category) { menuItems in
            guard let menuItems = menuItems else {
                print(#line, #function, "Can't load menu items for category \(self.category ?? "nil")")
                return
            }
            self.updateUI(with: menuItems)
        }
    }
}

// MARK: - Navigation
extension MenuTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ItemDetailSegue" else { return }
        guard let index = tableView.indexPathForSelectedRow else { return }
        let destination = segue.destination as! MenuItemDetailViewController
        destination.menuItem = menuItems[index.row]
    }
}

// MARK: - UI Methods
extension MenuTableViewController {
    func updateUI(with menuItems: [MenuItem]) {
        DispatchQueue.main.async {
            self.menuItems = menuItems
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension MenuTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell")!
        cellController.configure(cell, with: menuItems[indexPath.row])
        return cell
    }
}
