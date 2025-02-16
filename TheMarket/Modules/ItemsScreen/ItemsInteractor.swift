//
//  ItemsMainInteractor.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 11.02.2025.
//

import UIKit

enum DefaultsKeys {
    static let queries: String = "queries"
}

final class ItemsInteractor: NSObject, ItemsBusinessLogic & ItemsDataStore {
    // MARK: - Fields
    private let presenter: ItemsPresentationLogic
    private let worker: ItemsWorkingLogic
    private let defaultsManager: DefaultsManagerLogic

    // MARK: - Variables
    var items: [Items.DataModel] = []
    
    // MARK: - Lifecycle
    init(
        presenter: ItemsPresentationLogic,
        worker: ItemsWorkingLogic,
        defaultsManager: DefaultsManagerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
        self.defaultsManager = defaultsManager
    }
    
    // MARK: - Methods
    func loadStart() {
        worker.fetchItems { [weak self] result in
            switch result {
            case .success(let items):
                self?.items = items
                self?.presenter.presentStart()
            case .failure(let error):
                self?.presenter.presentErrorState(error: error)
            }
        }
    }
    
    func loadItems(with title: String) {
        worker.searchItems(by: title) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let items):
                if items.isEmpty {
                    presenter.presentEmptyState(title)
                } else {
                    self.items.removeAll()
                    self.items = items
                    
                    writeDown(query: title)
                    
                    self.presenter.presentStart()
                }
            case .failure(let error):
                self.presenter.presentErrorState(error: error)
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
    
    // MARK: - Private methods
    private func writeDown(query: String) {
        var searchQueries: [String] = defaultsManager.get(
            forKey: DefaultsKeys.queries,
            defaultValue: []
        )
        
        searchQueries.removeAll { $0 == query }
        searchQueries.insert(query, at: 0)
        if searchQueries.count > 5 {
            searchQueries.removeLast()
        }

        defaultsManager.set(
            forKey: DefaultsKeys.queries, value: searchQueries
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

// MARK: - UITableViewDataSource
extension ItemsInteractor: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        let numberOfQueries = defaultsManager.get(
            forKey: DefaultsKeys.queries,
            defaultValue: []
        ).count
        
        return numberOfQueries
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchHistoryCell.reuseIdentifier,
            for: indexPath
        )
        
        guard let searchHistoryCell = cell as? SearchHistoryCell else { return cell }
        
        let queries: [String] = defaultsManager.get(
            forKey: DefaultsKeys.queries,
            defaultValue: []
        )
        
        searchHistoryCell.configure(
            with: Items.SearchQueryViewModel(query: queries[indexPath.row])
        )
        return searchHistoryCell
    }
}
