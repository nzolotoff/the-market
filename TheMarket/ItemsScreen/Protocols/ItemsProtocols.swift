//
//  ItemsMainProtocols.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 11.02.2025.
//

protocol ItemsBusinessLogic {
    func loadStart(_ request: ItemsModel.Start.Request)
}

protocol ItemsPresentationLogic {
    func presentStart(_ response: ItemsModel.Start.Response)
    
    func routeTo()
}
