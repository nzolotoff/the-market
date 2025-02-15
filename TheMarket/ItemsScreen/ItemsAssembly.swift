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
        let worker = ItemsWorker()
        let interactor = ItemsInteractor(presenter: presenter, worker: worker)
        let view = ItemsViewController(interactor: interactor)
        
        presenter.view = view
        
        return view
    }
}
