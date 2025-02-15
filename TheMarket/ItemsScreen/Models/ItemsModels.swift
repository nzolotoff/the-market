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
        
//        init(dataModel: Items.DataModel) {
//            self.id = dataModel.id
//            self.imageURL = dataModel.images.first
//            self.title = dataModel.title
//            self.price = "$\(dataModel.price)"
//        }
    }
    
    struct SearchQueryViewModel {
        var query: String
    }
}

struct Category: Codable {
    let id: Int
    let name: Name
}

enum Name: String, Codable {
    case clothesItems = "Clothes Items"
    case electronics = "Electronics"
    case furniture = "Furniture"
    case laptop = "Laptop"
    case miscellaneous = "Miscellaneous"
    case royalItems = "Royal Items"
    case shoes = "Shoes"
    case string = "string"
}
