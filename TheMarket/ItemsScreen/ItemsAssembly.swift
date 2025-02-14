//
//  ItemsMainAssembly.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 11.02.2025.
//

import UIKit

enum ItemsAssembly {
    static func build() -> UIViewController {
        let presenter = ItemsPresenter()
        let interactor = ItemsInteractor(presenter: presenter)
        let view = ItemsViewController(interactor: interactor)
        
        presenter.view = view
        
        return view
    }
}
