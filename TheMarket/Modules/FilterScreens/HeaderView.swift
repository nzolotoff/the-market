//
//  HeaderView.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 14.02.2025.
//

import UIKit

final class HeaderView: UIView {
    // MARK: - Constants
    enum Constants {
        enum LeftButton {
            static let width: CGFloat = 20
            static let leftOffset: CGFloat = 20
        }
        
        enum TitleLabel {
            static let lines: Int = 1
        }
        
        enum RightButton {
            static let rightOffset: CGFloat = 20
        }
    }
    
    // MARK: - Fields
    private let leftButton: UIButton = UIButton(type: .system)
    private var titleLabel: UILabel = UILabel()
    private var rightButton: UIButton = UIButton(type: .system)
    
    var leftButtonAction: (() -> Void)?
    var rightButtonAction: (() -> Void)?
    
    // MARK: - Lyfecycle
    init(
        leftButtonImage: UIImage?,
        title: String,
        rightButtonTitle: String
    ) {
        super.init(frame: .zero)
        configureUI(
            leftButtonImage,
            title,
            rightButtonTitle
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    private func configureUI(
        _ image: UIImage?,
        _ text: String,
        _ title: String
    ) {        
        configureLeftButton(image)
        configureTitleLabel(text)
        configureRightButton(title)
    }
    
    private func configureLeftButton(_ image: UIImage?) {
        leftButton.backgroundColor = .clear
        leftButton.tintColor = UIColor(color: .accent)
        
        leftButton.setImage(image, for: .normal)
        leftButton.addTarget(
            self,
            action: #selector(leftButtonWasTapped),
            for: .touchUpInside
        )
        
        addSubview(leftButton)
        leftButton.pinVertical(to: self)
        leftButton.pinLeft(to: self, Constants.LeftButton.leftOffset)
        leftButton.setWidth(Constants.LeftButton.width)
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
        titleLabel.pinCenterX(to: self)
        titleLabel.pinVertical(to: self)
    }
    
    private func configureRightButton(_ title: String) {
        rightButton = ViewFactory.createButton(
            with: title,
            textStyle: .buttonSecondary,
            textColor: .buttonMinoryText
        )
        rightButton.backgroundColor = .clear
        rightButton.addTarget(
            self,
            action: #selector(rightButtonWasTapped),
            for: .touchUpInside
        )
        addSubview(rightButton)
        rightButton.pinVertical(to: self)
        rightButton.pinRight(
            to: self,
            Constants.RightButton.rightOffset
        )
    }
    
    // MARK: - Actions
    @objc private func leftButtonWasTapped() {
        leftButtonAction?()
    }
    
    @objc private func rightButtonWasTapped() {
        rightButtonAction?()
    }
}
