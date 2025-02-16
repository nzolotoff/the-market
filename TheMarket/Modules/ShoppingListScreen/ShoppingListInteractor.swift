//
//  ShoppingListInteractor.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

import UIKit

final class ShoppingListInteractor: NSObject, ShoppingListBusinessLogic {
    // MARK: - Fields
    private let presenter: ShoppingListPresentationLogic
    
    // MARK: - Variables
    var cartItems: [CartItemModel] = []
    
    // MARK: - Lifecycle
    init(presenter: ShoppingListPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func loadStart() {
        presenter.presentStart()
    }
    
    func loadPreviousScreen() {
        presenter.routeToPreviousScreen()
    }
    
    func loadSharingInfo() {
        
    }
}

// MARK: - UITableViewDataSource
extension ShoppingListInteractor: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 5
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemCartCell.reuseIdentifier,
            for: indexPath
        )
        
        guard let itemCartCell = cell as? ItemCartCell else {
            return cell
        }
        
        itemCartCell.configure(
            with: CartItemModel(
                id: 1,
                imageURL: "",
                title: "Some title",
                payout: "$186",
                quantity: 1
            )
        )
        return itemCartCell
    }
}
