//
//  ViewFactory.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 12.02.2025.
//

import UIKit

final class ViewFactory {
    // MARK: - Label
    static func createLabel(
        with text: String,
        textStyle: TextStyle,
        textColor: Color,
        alignment: NSTextAlignment,
        lines: Int
    ) -> UILabel {
        let label = UILabel()
        
        label.text = text
        label.font = textStyle.font
        label.textColor = UIColor(color: textColor)
        label.textAlignment = alignment
        label.numberOfLines = lines
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }
    
    // MARK: - Button
    static func createButton(
        with title: String,
        textStyle: TextStyle = .title1,
        textColor: Color = .buttonTextPrimary,
        buttonColor: Color = .accent,
        cornerRadius: CGFloat = 16
    ) -> UIButton {
        let button = UIButton(type: .system)
        
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = textStyle.font
        button.setTitleColor(UIColor(color: textColor), for: .normal)
        button.backgroundColor = UIColor(color: buttonColor)
        button.layer.cornerRadius = cornerRadius
        
        return button
    }
    
    static func createSystemIconButton(
        with systemName: String,
        configuration: UIImage.SymbolConfiguration = UIImage.SymbolConfiguration(
            pointSize: 16,
            weight: .medium
        ),
        tintColor: Color
    ) -> UIButton {
        let imageButton = UIButton(type: .system)
        
        imageButton.backgroundColor = .clear
        imageButton.tintColor = UIColor(color: tintColor)
        imageButton.setImage(
            UIImage(
                systemName: systemName,
                withConfiguration: configuration
            ),
            for: .normal
        )
        
        return imageButton
    }
    
    // MARK: - TextField
    static func createTextfield(
        with placeholder: String,
        placeholderColor: Color = .secondary,
        textStyle: TextStyle = .body,
        textColor: Color = .accent,
        backgroundColor: Color = .background,
        cornerRadius: CGFloat = 10
    ) -> UITextField {
        let textField = UITextField()
        
        textField.setPlaceholder(placeholder, color: placeholderColor)
        textField.font = textStyle.font
        textField.textColor = UIColor(color: textColor)
        textField.backgroundColor = UIColor(color: backgroundColor)
        textField.layer.cornerRadius = cornerRadius
        
        return textField
    }
}
