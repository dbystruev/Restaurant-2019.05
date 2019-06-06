//
//  OrderConfirmationViewController.swift
//  Restaurant 2019.05
//
//  Created by Denis Bystruev on 06.06.2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    @IBOutlet weak var timeRemainingLabel: UILabel!
    var minutes: Int!
}

// MARK: - UIViewController
extension OrderConfirmationViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.text = "Thank you for your order!  Your wait time is approximately \(minutes!) minutes"
    }
}
