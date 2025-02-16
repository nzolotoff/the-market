//
//  ItemCell.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

import UIKit

final class ItemCartCell: UITableViewCell {
    // MARK: - Constants
    enum Constants {
        
    }
    
    // MARK: - Identifier
    static let reuseIdentifier: String = "ItemCartCell"
    // MARK: - Fields
    private let wrapView: UIView = UIView()
    private let asyncImageView: AsyncImageView = AsyncImageView()
    private var titleLabel: UILabel = UILabel()
    private var payoutLabel: UILabel = UILabel()
    private var quantityview: ItemQuantityView = ItemQuantityView()
    private var infoStack: UIStackView = UIStackView()
    
    // MARK: - Lyfecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell congiguration
    func configure(with model: CartItemModel) {
        asyncImageView.setImage(imageURL: model.imageURL)
        titleLabel.text = model.title
        payoutLabel.text = model.payout
        quantityview.updateQuantity(counter: model.quantity)
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        configureWrapView()
        configureAsyncImageView()
        configureInfoStack()
        configureQuantityView()
    }
    
    private func configureWrapView() {
        wrapView.backgroundColor = .white
        
        addSubview(wrapView)
        wrapView.pin(to: self)
    }
    
    private func configureAsyncImageView() {
        wrapView.addSubview(asyncImageView)
        
        asyncImageView.pinLeft(to: wrapView, 20)
        asyncImageView.pinCenterY(to: wrapView)
        asyncImageView.setHeight(100)
        asyncImageView.setWidth(100)
    }
    
    private func configureInfoStack() {
        titleLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .title1,
            textColor: .secondary,
            alignment: .left,
            lines: 1
        )
        
        payoutLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .title2,
            textColor: .accent,
            alignment: .left,
            lines: 1
        )
        
        infoStack.axis = .vertical
        infoStack.spacing = 6
        infoStack.distribution = .equalSpacing
        
        infoStack.addArrangedSubviews(titleLabel, payoutLabel)
        
        wrapView.addSubview(infoStack)
        infoStack.pinLeft(to: asyncImageView.trailingAnchor, 20)
        infoStack.pinRight(to: wrapView, 20)
        infoStack.pinTop(to: wrapView, 11.5)
        infoStack.setHeight(46)
    }
    
    private func configureQuantityView() {
        
        wrapView.addSubview(quantityview)
        quantityview.pinTop(to: infoStack.bottomAnchor, 6)
        quantityview.pinLeft(to: infoStack)
        quantityview.setWidth(150)
        quantityview.setHeight(30)
    }
}
