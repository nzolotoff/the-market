//
//  CardProtocols.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

protocol CardBusinessLogic {
    func loadStart()
    func loadSharingInfo()
    func loadItemsScreen()
    func loadShoppingListScreen()

}

protocol CardPresentationLogic {
    func presentStart(_ responce: CardModel)
    func presentSharingInfo(_ responce: ItemSharingModel)
    
    func routeToItemsScreen()
    func routeToShoppingListScreen()
}
