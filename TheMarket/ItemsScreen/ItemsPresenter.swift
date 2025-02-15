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
    
    func presentItems() {
        
    }
        
    func presentError(error: Error) {
        view?.hideLoadingIndicator()
        view?.displayError(with: error)
    }
    
    // MARK: - Routing logic
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

}

