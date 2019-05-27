//
//  CategoryTableViewController.swift
//  Restaurant 2019.05
//
//  Created by Denis Bystruev on 27/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    override func viewDidLoad() {
        let menuController = MenuController()
        
        super.viewDidLoad()
        menuController.fetchCategories { categories in
            print(#line, #function, categories ?? [])
            
            var menuIds = [Int]()
            
            for category in categories ?? [] {
                menuController.fetchMenuItems(forCategory: category) { items in
                    print(#line, #function, items ?? [])
                    menuIds += (items ?? []).map { $0.id }
                    
                    if category == categories?.last {
                        print(#line, #function, menuIds)
                        menuController.submitOrder(forMenuIDs: menuIds) { preparationTime in
                            print(#line, #function, preparationTime ?? 0)
                        }
                    }
                }
            }
            
            
        }
        
    }
}
