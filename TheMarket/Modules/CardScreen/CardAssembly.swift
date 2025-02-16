//
//  CardAssembly.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

import UIKit

enum CardAssembly {
    static func build(_ model: CardModel) -> UIViewController {
        let presenter = CardPresenter()
        let interactor = CardInteractor(presenter: presenter, card: model)
        let view = CardViewController(interactor: interactor)
        
        presenter.view = view
        
        return view
    }
}
