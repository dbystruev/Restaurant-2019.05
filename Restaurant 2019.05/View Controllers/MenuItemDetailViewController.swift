//
//  MenuItemDetailViewController.swift
//  Restaurant 2019.05
//
//  Created by Denis Bystruev on 27/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    
    // MARK: - Properties
    var menuItem: MenuItem!
    let menuController = MenuController()
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateTopStackView(with: size)
    }
}

// MARK: - Actions
extension MenuItemDetailViewController {
    @IBAction func orderButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.transform = CGAffineTransform(scaleX: 3, y: 3)
            sender.transform = CGAffineTransform.identity
        }
        OrderController.shared.order.menuItems.append(menuItem)
    }
}

// MARK: - UI Methods
extension MenuItemDetailViewController {
    func setupUI() {
        adjustSizes()
        descriptionLabel.text = menuItem.detailText
        nameLabel.text = menuItem.name
        navigationItem.title = String(format: "$%.2f", menuItem.price)
        orderButton.layer.cornerRadius = 10
        updateTopStackView(with: view.bounds.size)
        menuController.fetchImage(url: menuItem.imageURL) { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    func updateTopStackView(with size: CGSize) {
        let isVertical = size.width < size.height
        topStackView.axis = isVertical ? .vertical : .horizontal
    }
}

// MARK: - SizeAdjustable
extension MenuItemDetailViewController: SizeAdjustable {}
