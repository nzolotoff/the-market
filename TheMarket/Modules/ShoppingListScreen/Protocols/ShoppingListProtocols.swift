//
//  ShoppingListProtocols.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

import UIKit

protocol ShoppingListBusinessLogic: UITableViewDataSource {
    func loadStart()
    func loadPreviousScreen()
    func loadSharingInfo()
}

protocol ShoppingListPresentationLogic {
    func presentStart()
    func presentSharingInfo(_ responce: CartItemsSharingModel)
    
    func routeToPreviousScreen()
}

protocol CartItemCoreDataManagerLogic {
    func createCartItem(with model: CartItemModel) throws
    func fetchCartItems() -> Result<[CartItemModel], CartItemManagerError>
//    func fetchCartItem(withId id: Int16) -> CartItemModel?
//    func deleteAllCartItems()
//    func deleteCartItemModel(withId id: Int16)
}
