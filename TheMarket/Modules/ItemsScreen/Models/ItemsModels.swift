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
        
        enum CodingKeys: String, CodingKey {
            case id, title, price, description, images, creationAt, updatedAt, category
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            id = try container.decode(Int.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title)
            price = try container.decode(Int.self, forKey: .price)
            description = try container.decode(String.self, forKey: .description)
            creationAt = try container.decode(String.self, forKey: .creationAt)
            updatedAt = try container.decode(String.self, forKey: .updatedAt)
            category = try container.decode(Category.self, forKey: .category)
            
            let imageStrings = try container.decode([String].self, forKey: .images)
            self.images = imageStrings.flatMap { image -> [String] in
                if let jsonString = image.trimmingCharacters(in: .whitespacesAndNewlines).removingPercentEncoding,
                   jsonString.hasPrefix("[") && jsonString.hasSuffix("]") {
                    return jsonString
                        .replacingOccurrences(of: "[", with: "")
                        .replacingOccurrences(of: "]", with: "")
                        .split(separator: ",")
                        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                }
                
                return [image]
            }
        }
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

struct Category: Codable {
    let id: Int
    let name: Name
    let image: String
}

enum Name: String, Codable {
    case clothes = "Clothes"
    case electronics = "Electronics"
    case furniture = "Furniture"
    case miscellaneous = "Miscellaneous"
    case shoes = "Shoes"
}
