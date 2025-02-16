//
//  ShoppingListModels.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

import Foundation

// MARK: - Type of error
public enum CartItemManagerError: Error {
    case entityNotFound
    case listOfItemsNotFound
}

struct CartItemModel {
    var id: Int
    var imageURL: String
    var title: String
    var payout: String
    var quantity: Int
}

struct CartItemsSharingModel {
    
}
