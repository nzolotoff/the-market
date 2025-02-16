//
//  PriceInteractor.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 14.02.2025.
//

final class PriceInteractor: PriceBusinessLogic {
    // MARK: - Fields
    private let presenter: PricePresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: PricePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func loadStart(_ request: Model.Start.Request) {
        presenter.presentStart(Model.Start.Response())
    }
    
    func loadCloseScreen() {
        presenter.presentCloseScreen()
    }
}
