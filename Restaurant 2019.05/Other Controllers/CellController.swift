//
//  CellController.swift
//  Restaurant 2019.05
//
//  Created by Denis Bystruev on 30/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

final class CellController {
    let menuController = MenuController()
    
    func configure(_ cell: UITableViewCell, with category: String) {
        cell.textLabel?.text = category.capitalized(with: Locale.current)
    }
    
    func configure(_ cell: UITableViewCell, with menuItem: MenuItem) {
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
        menuController.fetchImage(url: menuItem.imageURL) { image in
            DispatchQueue.main.async {
                cell.imageView?.image = image
            }
        }
    }
}
