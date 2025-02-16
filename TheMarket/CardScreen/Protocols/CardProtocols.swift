//
//  CardProtocols.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

protocol CardBusinessLogic {
    func loadStart()
    
}

protocol CardPresentationLogic {
    func presentStart(_ responce: CardModel)
    
    func routeTo()
}
