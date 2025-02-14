//
//  ItemsMainProtocols.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 11.02.2025.
//

protocol ItemsBusinessLogic {
    func loadStart(_ request: ItemsModel.Start.Request)
    func loadCategoryScreen()
    func loadPriceScreen()
}

protocol ItemsPresentationLogic {
    func presentStart(_ response: ItemsModel.Start.Response)
    
    func routeToCategoryScreen()
    func routeToPriceScreen()
}
