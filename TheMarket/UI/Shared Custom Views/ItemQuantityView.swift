//
//  ItemQuantityView.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

import UIKit

final class ItemQuantityView: UIView {
    // MARK: - Constants
    enum Constants {
        
    }
    
    // MARK: - Fields
    private var quantityLabel: UILabel = UILabel()
    private var decreaseButton: UIButton = UIButton(type: .system)
    private var increaseButton: UIButton = UIButton(type: .system)

    var decreaseButtonAction: (() -> Void)?
    var increaseButtonAction: (() -> Void)?
    
    // MARK: - Lyfecycle
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func updateQuantity(counter: Int) {
        quantityLabel.text = String(counter)
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        backgroundColor = UIColor(color: .background)
        layer.cornerRadius = 16
        
        configureDecreaseButton()
        configureIncreaseButton()
        configureQuantityLabel()
    }
    
    private func configureDecreaseButton() {
        decreaseButton = ViewFactory.createSystemIconButton(
            with: "minus",
            configuration: UIImage.SymbolConfiguration(
                pointSize: 16,
                weight: .regular
            ),
            tintColor: .accent
        )
        decreaseButton.addTarget(
            self,
            action: #selector(decreaseButtonWasTapped),
            for: .touchUpInside
        )
        
        addSubview(decreaseButton)
        decreaseButton.pinLeft(to: self)
        decreaseButton.pinVertical(to: self)
        decreaseButton.setWidth(55)
    }
    
    private func configureIncreaseButton() {
        increaseButton = ViewFactory.createSystemIconButton(
            with: "plus",
            configuration: UIImage.SymbolConfiguration(
                pointSize: 16,
                weight: .regular
            ),
            tintColor: .accent
        )
        increaseButton.addTarget(
            self,
            action: #selector(increaseButtonWasTapped),
            for: .touchUpInside
        )
        addSubview(increaseButton)
        increaseButton.pinRight(to: self)
        increaseButton.pinVertical(to: self)
        increaseButton.pinWidth(to: decreaseButton)
    }
    
    private func configureQuantityLabel() {
        quantityLabel = ViewFactory.createLabel(
            with: "0",
            textStyle: .title1,
            textColor: .accent,
            alignment: .center,
            lines: 1
        )
        
        addSubview(quantityLabel)
        quantityLabel.pinVertical(to: self)
        quantityLabel.pinLeft(to: decreaseButton.trailingAnchor, 2)
        quantityLabel.pinRight(to: increaseButton.leadingAnchor, 2)
    }
    
    // MARK: - Actions
    @objc private func decreaseButtonWasTapped() {
        decreaseButtonAction?()
    }
    
    @objc private func increaseButtonWasTapped() {
        increaseButtonAction?()
    }
}
