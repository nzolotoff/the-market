//
//  ItemsMainProtocols.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 11.02.2025.
//

import UIKit

protocol ItemsBusinessLogic: UICollectionViewDataSource, UITableViewDataSource {
    func loadStart()
    func loadNewItems()
    func loadCategoryFilterScreen()
    func loadPriceFilterScreen()
    func loadCardScreen(for id: Int)
    func loadShoppingListScreen()
    func loadItems(with title: String)
}

protocol ItemsPresentationLogic {
    func presentStart()
    func presentError(error: Error)
    
    func routeToCategoryFilterScreen()
    func routeToPriceFilterScreen()
    func routeToCardScreen(with responce: CardModel)
    func routeShoppingListScreen()
}

protocol ItemsDataStore {
    var items: [Items.DataModel] { get }
}

protocol ItemsWorkingLogic {
    func searchItems(by title: String, completion: @escaping (Result<[Items.DataModel], Error>) -> Void)
    func fetchItems(completion: @escaping (Result<[Items.DataModel], Error>) -> Void)
}


