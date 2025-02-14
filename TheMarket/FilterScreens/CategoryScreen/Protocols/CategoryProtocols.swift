//
//  CategoryProtocols.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 14.02.2025.
//

protocol CategoryBusinessLogic {
    func loadStart(_ request: CategoryModels.Start.Request)
    func loadCloseScreen()
}

protocol CategoryPresentationLogic {
    func presentStart(_ response: CategoryModels.Start.Response)
    func presentCloseScreen()
    
    func routeTo()
}

