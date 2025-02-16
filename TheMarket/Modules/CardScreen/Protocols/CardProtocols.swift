//
//  CardProtocols.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

protocol CardBusinessLogic {
    func loadStart()
    func loadItemsScreen()
    func loadSharingInfo()
}

protocol CardPresentationLogic {
    func presentStart(_ responce: CardModel)
    func presentSharingInfo(_ responce: ItemSharingModel)
    
    func routeToItemsScreen()
}
