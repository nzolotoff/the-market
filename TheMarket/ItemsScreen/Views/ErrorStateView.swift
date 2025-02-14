//
//  ErrorStateView.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 15.02.2025.
//

import UIKit

final class ErrorStateView: UIView {
    // MARK: - Constants
    enum Constants {
        enum IconImageView {
            static let topOffset: CGFloat = 52
            static let horizontalOffset: CGFloat = 121
            static let height: CGFloat = 160
            static let width: CGFloat = 160
        }
        
        enum TitleLabel {
            static let lines: Int = 1
            static let topOffset: CGFloat = 24
            static let horizontalOffset: CGFloat = 52
            static let height: CGFloat = 30
        }
        
        enum ParagraphLabel {
            static let lines: Int = 0
            static let topOffset: CGFloat = 24
            static let horizontalOffset: CGFloat = 64
        }
        
        enum TryAgainButton {
            static let title: String = "Try again"
            static let topOffset: CGFloat = 24
            static let horizontalOffset: CGFloat = 20
            static let height: CGFloat = 48
        }
    }
    
    // MARK: - Fields
    private let iconImageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var paragraphLabel: UILabel = UILabel()
    private var tryAgainButton: UIButton = UIButton(type: .system)
    
    var buttonAction: (() -> Void)?
    
    // MARK: - Lyfecycle
    init(icon: UIImage?, title: String, caption: String) {
        super.init(frame: .zero)
        configureUI(icon, title, caption)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    private func configureUI(
        _ icon: UIImage?,
        _ title: String,
        _ caption: String
    ) {
        configureIconImageView(icon)
        configureTitleLabel(title)
        configureParagraphLabel(caption)
        configureTryAgainButton()
    }
    
    private func configureIconImageView(_ image: UIImage?) {
        iconImageView.image = image
        
        addSubview(iconImageView)
        iconImageView.pinTop(to: self, Constants.IconImageView.topOffset)
        iconImageView.pinHorizontal(to: self, Constants.IconImageView.horizontalOffset)
        iconImageView.setWidth(Constants.IconImageView.width)
        iconImageView.setHeight(Constants.IconImageView.height)
    }
    
    private func configureTitleLabel(_ text: String) {
        titleLabel = ViewFactory.createLabel(
            with: text,
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
        titleLabel.pinHorizontal(
            to: self,
            Constants.TitleLabel.horizontalOffset
        )
        titleLabel.setHeight(Constants.TitleLabel.height)
    }
    
    private func configureParagraphLabel(_ text: String) {
        paragraphLabel = ViewFactory.createLabel(
            with: text,
            textStyle: .paragraph,
            textColor: .secondary,
            alignment: .center,
            lines: Constants.ParagraphLabel.lines
        )
        
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
    
    private func configureTryAgainButton() {
        tryAgainButton = ViewFactory.createButton(
            with: Constants.TryAgainButton.title
        )
        tryAgainButton.addTarget(
            self,
            action: #selector(tryAgainButtonWasTapped),
            for: .touchUpInside
        )
        
        addSubview(tryAgainButton)
        tryAgainButton.pinTop(
            to: paragraphLabel.bottomAnchor,
            Constants.TryAgainButton.topOffset
        )
        tryAgainButton.pinHorizontal(
            to: self,
            Constants.TryAgainButton.horizontalOffset
        )
        tryAgainButton.setHeight(Constants.TryAgainButton.height)
    }
    
    // MARK: - Actions
    @objc private func tryAgainButtonWasTapped() {
        buttonAction?()
    }
}
