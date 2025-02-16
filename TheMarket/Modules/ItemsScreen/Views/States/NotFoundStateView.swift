//
//  NotFoundStateView.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 15.02.2025.
//

import UIKit

final class View: UIView {
    // MARK: - Constants
    enum Constants {
        enum IconImageView {
            static let image: UIImage? = UIImage(
                systemName: "magnifyingglass",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 96,
                    weight: .medium
                )
            )
            static let topOffset: CGFloat = 52
            static let horizontalOffset: CGFloat = 140
            static let height: CGFloat = 122
            static let width: CGFloat = 122
        }
        
        enum TitleLabel {
            static let title: String = "Item not found"
            static let lines: Int = 1
            static let topOffset: CGFloat = 24
            static let horizontalOffset: CGFloat = 104
            static let height: CGFloat = 32
        }
        
        enum ParagraphLabel {
            static let lines: Int = 0
            static let topOffset: CGFloat = 24
            static let horizontalOffset: CGFloat = 52
        }
    }
    
    // MARK: - Fields
    private let iconImageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var paragraphLabel: UILabel = UILabel()
    
    // MARK: - Lyfecycle
    init(queryName: String) {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        
    }
    
    private func configureIconImageView() {
        iconImageView.image = Constants.IconImageView.image
        iconImageView.tintColor = UIColor(color: .background)
        
        addSubview(iconImageView)
        iconImageView.pinTop(to: self, Constants.IconImageView.topOffset)
        iconImageView.pinHorizontal(
            to: self,
            Constants.IconImageView.horizontalOffset
        )
        iconImageView.setHeight(Constants.IconImageView.height)
        iconImageView.setWidth(Constants.IconImageView.width)
    }
    
    private func configureTitleLabel() {
        titleLabel = ViewFactory.createLabel(
            with: Constants.TitleLabel.title,
            textStyle: .title1,
            textColor: .accent,
            alignment: .center,
            lines: Constants.TitleLabel.lines
        )
        
        addSubview(titleLabel)
        titleLabel.pinTop(
            to: iconImageView.bottomAnchor,
            Constants.TitleLabel.topOffset
        )
        titleLabel.pinHorizontal(to: self, Constants.TitleLabel.horizontalOffset)
        titleLabel.setHeight(Constants.TitleLabel.height)
    }
    
    private func configureParagraphLabel(_ queryName: String) {
        paragraphLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .paragraph,
            textColor: .secondary,
            alignment: .center,
            lines: Constants.ParagraphLabel.lines
        )
        paragraphLabel.text = "Nothing could be found for the <<\(queryName)>> query"
        
        addSubview(paragraphLabel)
        paragraphLabel.pinTop(
            to: titleLabel.bottomAnchor,
            Constants.ParagraphLabel.topOffset
        )
        paragraphLabel.pinHorizontal(
            to: self,
            Constants.ParagraphLabel.horizontalOffset
        )
    }
}
