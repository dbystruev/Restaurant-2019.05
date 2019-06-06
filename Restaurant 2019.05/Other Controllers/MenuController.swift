//
//  MenuController.swift
//  Restaurant 2019.05
//
//  Created by Denis Bystruev on 27/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

final class MenuController {
    let baseURL = URL(string: "http://server.getoutfit.ru:8090/")!
    
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            let categories = jsonDictionary?["categories"] as? [String]
            completion(categories)
        }
        task.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let baseURLComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.host = baseURLComponents.host
        guard let url = components?.url else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
            return
        }
        task.resume()
    }
    
    func fetchMenuItems(forCategory category: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        guard let menuURL = initialMenuURL.withQueries(["category": category]) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: menuURL) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            let jsonDecoder = JSONDecoder()
            let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data)
            completion(menuItems?.items)
        }
        task.resume()
    }
    
    func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            let jsonDecoder = JSONDecoder()
            let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data)
            completion(preparationTime?.prepTime)
        }
        task.resume()
    }
}
