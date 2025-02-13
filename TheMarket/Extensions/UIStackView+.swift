//
//  UIStackView+.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 12.02.2025.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
    
    func addArrangedSubviews(_ views: UIView...) {
        addArrangedSubviews(views)
    }
}
