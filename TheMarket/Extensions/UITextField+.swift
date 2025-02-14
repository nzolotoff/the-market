//
//  UITextField+PlaceholderColor.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 12.02.2025.
//

import UIKit

extension UITextField {
    func setPlaceholder(_ text: String, color: Color) {
        self.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(color: color)]
        )
    }
}

