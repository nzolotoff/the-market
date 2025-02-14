//
//  ItemsMainScreenModels.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 11.02.2025.
//
import UIKit

enum ItemsModel {
    enum Start {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
}

struct ItemModel {
    var image: UIImage
    var title: String
    var category: String
    var price: String
}

struct SearchQueryModel {
    var query: String
}
