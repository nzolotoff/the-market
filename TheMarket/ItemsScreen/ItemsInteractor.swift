//
//  ItemsMainInteractor.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 11.02.2025.
//

final class ItemsInteractor: ItemsBusinessLogic {
    
    // MARK: - Fields
    private let presenter: ItemsPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: ItemsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func loadStart(_ request: ItemsModel.Start.Request) {
        presenter.presentStart(ItemsModel.Start.Response())
    }
    
    func loadCategoryScreen() {
        presenter.routeToCategoryScreen()
    }
    
    func loadPriceScreen() {
        presenter.routeToPriceScreen()
    }
    
}
