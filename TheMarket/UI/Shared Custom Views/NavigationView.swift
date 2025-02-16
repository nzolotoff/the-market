//
//  NavigationView.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

import UIKit

final class NavigationView: UIView {
    // MARK: - Constants
    enum Constants {
        enum GoBackIconButton {
            static let topOffset: CGFloat = 16
            static let leadingOffset: CGFloat = 12
            static let width: CGFloat = 32
            static let imageName: String = "chevron.backward"
            static let configuration: UIImage.SymbolConfiguration = UIImage.SymbolConfiguration(
                pointSize: 16,
                weight: .medium
            )
        }
        
        enum ShareIconButton {
            static let trailingOffset: CGFloat = 20
            static let width: CGFloat = 32
            static let imageName: String = "arrowshape.turn.up.right.fill"
            static let configuration: UIImage.SymbolConfiguration = UIImage.SymbolConfiguration(
                pointSize: 16,
                weight: .medium
            )
        }
    }
    
    // MARK: - Fields
    private var goBackIconButton: UIButton = UIButton(type: .system)
    private var shareIconButton: UIButton = UIButton(type: .system)
    private var titleLabel: UILabel = UILabel()
    
    var goBackIconButtonAction: (() -> Void)?
    var shareIconButtonAction: (() -> Void)?

    
    // MARK: - Lyfecycle
    init(title: String) {
        super.init(frame: .zero)
        configureUI(with: title)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    private func configureUI(with title: String) {
        configureLeftIconButton()
        configureShareIconButton()
        configureTitleLabel(title)
    }
    
    private func configureLeftIconButton() {
        goBackIconButton = ViewFactory.createSystemIconButton(
            with: Constants.GoBackIconButton.imageName,
            configuration: Constants.GoBackIconButton.configuration,
            tintColor: .accent
        )
        
        goBackIconButton.addTarget(
            self,
            action: #selector(goBackButtonWasTapped),
            for: .touchUpInside
        )
        
        self.addSubview(goBackIconButton)
        goBackIconButton.pinTop(
            to: self.safeAreaLayoutGuide.topAnchor,
            Constants.GoBackIconButton.topOffset
        )
        goBackIconButton.pinLeft(to: self, Constants.GoBackIconButton.leadingOffset)
        goBackIconButton.setWidth(Constants.GoBackIconButton.width)
        goBackIconButton.pinVertical(to: self)
    }
    
    private func configureShareIconButton() {
        shareIconButton = ViewFactory.createSystemIconButton(
            with: Constants.ShareIconButton.imageName,
            configuration: Constants.ShareIconButton.configuration,
            tintColor: .accent
        )
        
        shareIconButton.addTarget(
            self,
            action: #selector(shareButtonWasTapped),
            for: .touchUpInside
        )
        
        self.addSubview(shareIconButton)
        shareIconButton.pinTop(to: goBackIconButton)
        shareIconButton.pinRight(
            to: self,
            Constants.ShareIconButton.trailingOffset
        )
        shareIconButton.setWidth(Constants.ShareIconButton.width)
        shareIconButton.pinVertical(to: self)
    }
    
    private func configureTitleLabel(_ text: String) {
        titleLabel = ViewFactory.createLabel(
            with: text,
            textStyle: .paragraph,
            textColor: .accent,
            alignment: .center,
            lines: 1
        )
        
        self.addSubview(titleLabel)
        titleLabel.pinCenterY(to: self)
        titleLabel.pinLeft(to: goBackIconButton.trailingAnchor)
        titleLabel.pinRight(to: shareIconButton.leadingAnchor)
    }
    
    // MARK: - Actions
    @objc private func goBackButtonWasTapped() {
        goBackIconButtonAction?()
    }
    
    @objc private func shareButtonWasTapped() {
        shareIconButtonAction?()
    }
}
