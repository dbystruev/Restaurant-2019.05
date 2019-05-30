//
//  CategoryTableViewController.swift
//  Restaurant 2019.05
//
//  Created by Denis Bystruev on 27/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    // MARK: Properties
    let cellController = CellController()
    let menuController = MenuController()
    var categories = [String]()
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        menuController.fetchCategories { categories in
            guard let categories = categories else {
                print(#line, #function, "Can't load the list of categories")
                return
            }
            self.updateUI(with: categories)
        }
    }
    
    // MARK: - UI Methods
    func updateUI(with categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.tableView.reloadData()
        }
    }
}

// MARK: - Navigation
extension CategoryTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "MenuSegue" else { return }
        guard let index = tableView.indexPathForSelectedRow else { return }
        let destination = segue.destination as! MenuTableViewController
        destination.category = categories[index.row]
    }
}

// MARK: - UITableViewDataSource
extension CategoryTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")!
        cellController.configure(cell, with: categories[indexPath.row])
        return cell
    }
}
