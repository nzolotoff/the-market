//
//  ItemsMainPresenter.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 11.02.2025.
//

final class ItemsPresenter: ItemsPresentationLogic {
    // MARK: - Variables
    weak var view: ItemsViewController?
    
    // MARK: - Presentation logic
    func presentStart(_ response: ItemsModel.Start.Response) {
        
    }
    
    // MARK: - Routing logic
    func routeToCategoryScreen() {
        let categoryVC = CategoryAssembly.build()
        
        categoryVC.modalPresentationStyle = .pageSheet
        view?.present(categoryVC, animated: true)
    }
    
    func routeToPriceScreen() {
        let priceVC = PriceAssembly.build()
        
        priceVC.modalPresentationStyle = .pageSheet
        view?.present(priceVC, animated: true)
    }

}

