//
//  ItemCell.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 13.02.2025.
//

import UIKit

final class ItemCell: UICollectionViewCell {
    // MARK: - Constants
    enum Constants {
        static let reuseIdentifier: String = "ItemCell"
        
        enum ItemImageView {
            static let cornerRadius:  CGFloat = 10
            static let height: CGFloat = 108
        }
        
        enum titleLabel {
            static let lines: Int = 1
            static let TopOffset: CGFloat = 6
        }
        
        enum categoryLabel {
            static let lines: Int = 1
            static let TopOffset: CGFloat = 4
        }
        
        enum priceLabel {
            static let lines: Int = 1
        }
    }
    
    // MARK: - Fields
    static let reuseIdentifier: String = Constants.reuseIdentifier
    
    private let wrapView: UIView = UIView()
    private let itemImageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var categoryLabel: UILabel = UILabel()
    private var priceLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    // MARK: - Cell Configuration
    func configure(with model: ItemModel) {
        itemImageView.image = model.image
        titleLabel.text = model.title
        categoryLabel.text = model.category
        priceLabel.text = "$" + model.price
    }
    
    
    // MARK: - Configure UI
    private func configureUI() {
        configureWrapView()
        configureItemImageView()
        configureTitleLabel()
        configureCategoryLabel()
        configurePriceLabel()
    }
    
    private func configureWrapView() {
        
        addSubview(wrapView)
        wrapView.pin(to: self)
        wrapView.backgroundColor = .white
    }
    
    private func configureItemImageView() {
        itemImageView.layer.cornerRadius = Constants.ItemImageView.cornerRadius
        itemImageView.contentMode = .scaleToFill
        itemImageView.clipsToBounds = true
        
        wrapView.addSubview(itemImageView)
        itemImageView.pinTop(to: wrapView)
        itemImageView.pinHorizontal(to: wrapView)
        itemImageView.setHeight(Constants.ItemImageView.height)
    }
    
    private func configureTitleLabel() {
        titleLabel =  ViewFactory.createLabel(
            with: "",
            textStyle: .title1,
            textColor: .primary,
            alignment: .left,
            lines: Constants.titleLabel.lines
        )
        
        wrapView.addSubview(titleLabel)
        titleLabel.pinTop(to: itemImageView.bottomAnchor, Constants.titleLabel.TopOffset)
        titleLabel.pinHorizontal(to: wrapView)
    }
    
    private func configureCategoryLabel() {
        categoryLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .caption,
            textColor: .secondary,
            alignment: .left,
            lines: Constants.categoryLabel.lines
        )
        
        wrapView.addSubview(categoryLabel)
        categoryLabel.pinTop(to: titleLabel.bottomAnchor, Constants.categoryLabel.TopOffset)
        categoryLabel.pinLeft(to: wrapView)
    }
    
    private func configurePriceLabel() {
        priceLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .title2,
            textColor: .accent,
            alignment: .right,
            lines: Constants.priceLabel.lines
        )
        
        wrapView.addSubview(priceLabel)
        priceLabel.pinRight(to: wrapView)
        priceLabel.pinBottom(to: wrapView)
        priceLabel.setContentCompressionResistancePriority(
            .defaultHigh,
            for: .horizontal
        )
    }
}
