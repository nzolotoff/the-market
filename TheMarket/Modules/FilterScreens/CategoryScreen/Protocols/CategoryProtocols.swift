//
//  CategoryProtocols.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 14.02.2025.
//

protocol CategoryBusinessLogic {
    func loadStart()
    func loadCloseScreen()
}

protocol CategoryPresentationLogic {
    func presentStart()
    func presentCloseScreen()
    
    func routeTo()
}

