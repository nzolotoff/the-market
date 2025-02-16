//
//  ItemsMainProtocols.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 11.02.2025.
//

import UIKit

protocol ItemsBusinessLogic: UICollectionViewDataSource {
    func loadStart()
    func loadNewItems()
    func loadCategoryFilterScreen()
    func loadPriceFilterScreen()
    func loadCardScreen(for id: Int)
}

protocol ItemsPresentationLogic {
    func presentStart()
    func presentItems()
    func presentError(error: Error)
    
    func routeToCategoryFilterScreen()
    func routeToPriceFilterScreen()
    func routeToCardScreen(with responce: CardModel)
}

protocol ItemsDataStore {
    var items: [Items.DataModel] { get }
}

protocol ItemsWorkingLogic {
    func fetchItems(completion: @escaping (Result<[Items.DataModel], Error>) -> Void)
}

