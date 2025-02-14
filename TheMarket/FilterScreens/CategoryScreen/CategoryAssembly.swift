//
//  CategoryAssembly.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 14.02.2025.
//

import UIKit

enum CategoryAssembly {
    static func build() -> UIViewController {
        let presenter = CategoryPresenter()
        let interactor = CategoryInteractor(presenter: presenter)
        let view = CategoryViewController(interactor: interactor)
        
        presenter.view = view
        
        return view
    }
}
