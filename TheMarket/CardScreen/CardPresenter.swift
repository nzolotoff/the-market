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

    func routeTo() {

    }
}
