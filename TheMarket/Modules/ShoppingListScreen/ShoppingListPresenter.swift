//
//  ShoppingListPresenter.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

final class ShoppingListPresenter: ShoppingListPresentationLogic {
    // MARK: - Variables
    weak var view: ShoppingListViewController?
    
    // MARK: - Methods
    func presentStart() {
        view?.displayStart()
    }
    
    func routeTo() {
        
    }
}
