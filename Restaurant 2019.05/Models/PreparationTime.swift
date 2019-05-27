//
//  PreparationTime.swift
//  Restaurant 2019.05
//
//  Created by Denis Bystruev on 27/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
