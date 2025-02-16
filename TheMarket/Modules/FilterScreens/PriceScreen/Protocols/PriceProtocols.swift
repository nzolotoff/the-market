//
//  PriceProtocols.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 14.02.2025.
//

protocol PriceBusinessLogic {
    func loadStart(_ request: Model.Start.Request)
    func loadCloseScreen()
}

protocol PricePresentationLogic {
    func presentStart(_ response: Model.Start.Response)
    func presentCloseScreen()
    
    func routeTo()
}
