//
//  ShoppingListInteractor.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

final class ShoppingListInteractor: ShoppingListBusinessLogic {
    // MARK: - Fields
    private let presenter: ShoppingListPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: ShoppingListPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func loadStart() {
        presenter.presentStart()
    }
    
}
