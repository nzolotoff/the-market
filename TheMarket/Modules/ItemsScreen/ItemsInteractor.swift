//
//  ItemsMainInteractor.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 11.02.2025.
//

import UIKit

final class ItemsInteractor: NSObject, ItemsBusinessLogic & ItemsDataStore {
    // MARK: - Fields
    private let presenter: ItemsPresentationLogic
    private let worker: ItemsWorkingLogic
    
    // MARK: - Variables
    var items: [Items.DataModel] = []
    
    // MARK: - Lifecycle
    init(presenter: ItemsPresentationLogic, worker: ItemsWorkingLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Methods
    func loadStart() {
        worker.fetchItems { [weak self] result in
            switch result {
            case .success(let items):
                self?.items = items
                self?.presenter.presentStart()
            case .failure(let error):
                self?.presenter.presentError(error: error)
            }
        }
    }
    
    func loadItems(with title: String) {
        worker.searchItems(by: title) { [weak self] result in
            switch result {
            case .success(let items):
                self?.items.removeAll()
                self?.items = items
                self?.presenter.presentStart()
            case .failure(let error):
                self?.presenter.presentError(error: error)
            }
        }
    }
    
    func loadNewItems() {
        items.removeAll()
        loadStart()
    }
    
    func loadShoppingListScreen() {
        presenter.routeShoppingListScreen()
    }
    
    func loadCategoryFilterScreen() {
        presenter.routeToCategoryFilterScreen()
    }
    
    func loadPriceFilterScreen() {
        presenter.routeToPriceFilterScreen()
    }
    
    func loadCardScreen(for id: Int) {
        presenter.routeToCardScreen(
            with: CardModel(
                imageURL: items[id].images.first,
                price: "\(items[id].price)",
                title: items[id].title,
                category: items[id].category.name,
                description: items[id].description
            )
        )
    }
}

// MARK: - UICollectionViewDataSource
extension ItemsInteractor: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ItemCell.reuseIdentifier,
            for: indexPath
        )
        
        guard let itemCell = cell as? ItemCell else {
            return cell
        }
        
        itemCell.configure(
            with: items[indexPath.row].images.first,
            title: items[indexPath.row].title,
            price: "$\(items[indexPath.row].price)"
        )
        
        return cell
    }
}
