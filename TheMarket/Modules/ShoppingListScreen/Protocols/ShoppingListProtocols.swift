//
//  ShoppingListProtocols.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

protocol ShoppingListBusinessLogic {
    func loadStart()
}

protocol ShoppingListPresentationLogic {
    func presentStart()
    
    func routeTo()
}
