//
//  PriceAssembly.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 14.02.2025.
//

import UIKit

enum PriceAssembly {
    static func build() -> UIViewController {
        let presenter = Presenter()
        let interactor = PriceInteractor(presenter: presenter)
        let view = PriceViewController(interactor: interactor)
        
        presenter.view = view
        
        return view
    }
}
