//
//  PricePresenter.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 14.02.2025.
//

final class Presenter: PricePresentationLogic {
    // MARK: - Variables
    weak var view: PriceViewController?
    
    // MARK: - Methods
    func presentStart(_ response: Model.Start.Response) {
        
    }
     
    func presentCloseScreen() {
        view?.dismiss(animated: true)
    }
    
    func routeTo() {
        
    }
}
