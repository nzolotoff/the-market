//
//  ItemsMainPresenter.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 11.02.2025.
//

import Foundation

final class ItemsPresenter: ItemsPresentationLogic {
    // MARK: - Variables
    weak var view: ItemsViewController?
    
    // MARK: - Presentation logic
    func presentStart() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoadingIndicator()
            self?.view?.displayStart()
        }
    }
    
    func presentErrorState(error: Error) {
        view?.hideLoadingIndicator()
        view?.displayErrorState(with: error)
    }
    
    func presentEmptyState(_ responce: String) {
        view?.hideLoadingIndicator()
        view?.displayEmptyState(with: responce)
    }
    
    
    // MARK: - Routing logic
    func routeShoppingListScreen() {
        let shoppingListVC = ShoppingListAssembly.build()
        
        view?.navigationController?.pushViewController(
            shoppingListVC,
            animated: true
        )
    }
    
    func routeToCategoryFilterScreen() {
        let categoryVC = CategoryAssembly.build()
        
        categoryVC.modalPresentationStyle = .pageSheet
        view?.present(categoryVC, animated: true)
    }
    
    func routeToPriceFilterScreen() {
        let priceVC = PriceAssembly.build()
        
        priceVC.modalPresentationStyle = .pageSheet
        view?.present(priceVC, animated: true)
    }
    
    func routeToCardScreen(with responce: CardModel) {
        let CardVC = CardAssembly.build(responce)
        
        view?.navigationController?.pushViewController(
            CardVC,
            animated: true
        )
    }

}

