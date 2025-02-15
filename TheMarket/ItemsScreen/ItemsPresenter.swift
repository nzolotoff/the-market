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
            self?.view?.displayStart()
        }
    }
    
    func presentItems() {

    }
    
//    func presentItems(_ dataModels: [Items.DataModel]) {
//        var viewModels: [Items.ListViewModel] = []
//        for dataModel in dataModels {
//            let viewModel = Items.ListViewModel(
//                id: dataModel.id,
//                imageURL: dataModel.images.first,
//                title: dataModel.title,
//                price: String(dataModel.price)
//            )
//            viewModels.append(viewModel)
//        }
//    }
    
    func presentError(error: Error) {
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

