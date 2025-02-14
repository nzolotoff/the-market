//
//  CategoryPresenter.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 14.02.2025.
//

final class CategoryPresenter: CategoryPresentationLogic {
    
    // MARK: - Variables
    weak var view: CategoryViewController?
    
    // MARK: - Methods
    func presentStart(_ response: CategoryModels.Start.Response) {
        
    }
    
    func presentCloseScreen() {
        view?.dismiss(animated: true)
    }
    
    func routeTo() {
        
    }
}
