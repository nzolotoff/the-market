//
//  CategoryInteractor.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 14.02.2025.
//

final class CategoryInteractor: CategoryBusinessLogic {
    // MARK: - Fields
    private let presenter: CategoryPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: CategoryPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    func loadStart(_ request: CategoryModels.Start.Request) {
        presenter.presentStart(CategoryModels.Start.Response())
    }
    
    func loadCloseScreen() {
        presenter.presentCloseScreen()
    }
}
