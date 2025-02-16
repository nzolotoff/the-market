//
//  CardPresenter.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

import UIKit

final class CardPresenter: CardPresentationLogic {
    // MARK: - Variables
    weak var view: CardViewController?
    
    // MARK: - Methods
    func presentStart(_ responce: CardModel) {
        view?.displayStart(with: responce)
    }
    
    func presentSharingInfo(_ responce: ItemSharingModel) {
        let heading = "Look what I've found on TheMarket!"
        let title = responce.title + " just for " + "$" + responce.price + "!"
        
        let itemsToShare = [heading, title, responce.description]
        view?.displayItemSharing(itemsToShare)
    }

    func routeToItemsScreen() {
        view?.navigationController?.popViewController(animated: true)
    }
}
