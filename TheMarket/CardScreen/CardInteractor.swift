//
//  CardInteractor.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

import Foundation

final class CardInteractor: CardBusinessLogic {
    // MARK: - Fields
    private let presenter: CardPresentationLogic
    
    var card: CardModel
    
    
    // MARK: - Lifecycle
    init(presenter: CardPresentationLogic, card: CardModel) {
        self.presenter = presenter
        self.card = card
    }
    
    // MARK: - Methods
    func loadStart() {
        presenter.presentStart(card)
    }
    
}
