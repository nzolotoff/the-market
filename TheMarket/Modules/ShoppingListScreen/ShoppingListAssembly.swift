//
//  ShoppingListAssembly.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

import UIKit

enum ShoppingListAssembly {
    static func build() -> UIViewController {
        let presenter = ShoppingListPresenter()
        let interactor = ShoppingListInteractor(presenter: presenter)
        let view = ShoppingListViewController(interactor: interactor)
        
        presenter.view = view
        
        return view
    }
}
