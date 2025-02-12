//
//  Typography.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 12.02.2025.
//

import UIKit

enum Font: String {
    case light = "SF-Pro-Rounded-Light"
    case regular = "SF-Pro-Rounded-Regular"
    case medium = "SF-Pro-Rounded-Medium"
    case semibold = "SF-Pro-Rounded-Semibold"
    
    var name: String {
        return self.rawValue
    }
}

struct FontDescription {
    let font: Font
    let size: CGFloat
    let style: UIFont.TextStyle
}

enum TextStyle {
    case heading // 28 px sbd
    case title1 // 16 px sbd
    case title2 // 14 px sbd
    case titleLight // 14 px light
    
    case body // 16 px md
    
    case paragraph // 16px rg
    case caption // 12 px rg
    
    case buttonPrimary // 16 px sbd
    case buttonSecondary // 16 px rg
}

extension TextStyle {
    private var fontDescription: FontDescription {
        switch self {
        case .heading:
            return FontDescription(font: .semibold, size: 28, style: .largeTitle)
        case .title1:
            return FontDescription(font: .semibold, size: 16, style: .title1)
        case .title2:
            return FontDescription(font: .semibold, size: 14, style: .title2)
        case .titleLight:
            return FontDescription(font: .light, size: 14, style: .caption1)
        case .body:
            return FontDescription(font: .medium, size: 16, style: .body)
        case .paragraph:
            return FontDescription(font: .regular, size: 16, style: .body)
        case .caption:
            return FontDescription(font: .regular, size: 12, style: .caption1)
        case .buttonPrimary:
            return FontDescription(font: .semibold, size: 16, style: .headline)
        case .buttonSecondary:
            return FontDescription(font: .regular, size: 16, style: .body)
        }
    }
}

extension TextStyle {
    var font: UIFont {
        guard let font = UIFont(name: fontDescription.font.name, size: fontDescription.size) else {
            return UIFont.preferredFont(forTextStyle: fontDescription.style)
        }
        
        let fontMetrics = UIFontMetrics(forTextStyle: fontDescription.style)
        return fontMetrics.scaledFont(for: font)
    }
}
