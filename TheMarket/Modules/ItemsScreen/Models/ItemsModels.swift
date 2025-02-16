//
//  ItemsMainScreenModels.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 11.02.2025.
//

import UIKit

enum Items {
    struct DataModel: Codable {
        let id: Int
        let title: String
        let price: Int
        let description: String
        let images: [String]
        let creationAt, updatedAt: String
        let category: Category
    }
    
    struct Category: Codable {
        let id: Int
        let name: String
        let image: String
    }
    
    struct ListViewModel {
        let id: Int
        var imageURL: String?
        var title: String
        var price: String
    }
    
    struct SearchQueryViewModel {
        var query: String
    }
}
