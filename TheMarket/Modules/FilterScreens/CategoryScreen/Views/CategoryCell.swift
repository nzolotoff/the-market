//
//  CategoryCell.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 14.02.2025.
//

import UIKit

final class CategoryCell: UITableViewCell {
    // MARK: - Constants
    enum Constants {
        static let reuseIdentifier: String = "CategoryCell"
        
        enum unselectedImageView {
            static let image: UIImage? = UIImage(
                systemName: "square",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 20,
                    weight: .medium
                )
            )
            static let leftOffset: CGFloat = 20
            static let height: CGFloat = 24
            static let width: CGFloat = 24

        }
        
        enum selectedImageView {
            static let image: UIImage? = UIImage(
                systemName: "checkmark.square.fill",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 20,
                    weight: .medium
                )
            )
        }
        
        enum TitleLabel{
            static let leftOffset: CGFloat = 10
            static let rightOffset: CGFloat = 12
            static let height: CGFloat = 24
            static let lines: Int = 1

        }
    }
    
    // MARK: - Identifier
    static let reuseIdentifier: String = Constants.reuseIdentifier
    
    // MARK: - Fields
    private var isCategorySelected: Bool = false
    private let wrapView: UIView = UIView()
    private var unselectedImageView: UIImageView = UIImageView()
    private var selectedImageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    
    // MARK: - Lyfecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func updateState() {
        unselectedImageView.isHidden = isCategorySelected
        selectedImageView.isHidden = !isCategorySelected
    }
    
    func configure(with model: CategoryModel) {
        titleLabel.text = model.title
        isCategorySelected = model.isSelected
        updateState()
    }
    
    func updateCheckBoxState() {
        isCategorySelected = !isCategorySelected
        updateState()
    }
    
    func resetState() {
        isCategorySelected = false
        updateState()
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        configureWrapView()
        configureUnselectedImageView()
        configureSelectedImageView()
        configureTitleLabel()
    }
    
    private func configureWrapView() {
        addSubview(wrapView)
        wrapView.pin(to: self)
        wrapView.backgroundColor = .white
    }
    
    private func configureUnselectedImageView() {
        unselectedImageView.image = Constants.unselectedImageView.image
        unselectedImageView.tintColor = UIColor(color: .background)
        
        wrapView.addSubview(unselectedImageView)
        unselectedImageView.pinCenterY(to: wrapView)
        unselectedImageView.pinLeft(to: wrapView, Constants.unselectedImageView.leftOffset)
        unselectedImageView.setHeight(Constants.unselectedImageView.height)
        unselectedImageView.setWidth(Constants.unselectedImageView.width)
    }
    
    private func configureSelectedImageView() {
        selectedImageView.image = Constants.selectedImageView.image
        selectedImageView.tintColor = UIColor(color: .accent)
        
        wrapView.addSubview(selectedImageView)
        selectedImageView.pin(to: unselectedImageView)
    }
    
    private func configureTitleLabel() {
        titleLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .medium,
            textColor: .accent,
            alignment: .left,
            lines: Constants.TitleLabel.lines
        )
        
        wrapView.addSubview(titleLabel)
        titleLabel.pinLeft(to: unselectedImageView.trailingAnchor, Constants.TitleLabel.leftOffset)
        titleLabel.pinCenterY(to: wrapView)
        titleLabel.pinRight(to: wrapView, Constants.TitleLabel.rightOffset)
        titleLabel.setHeight(Constants.TitleLabel.height)
    }
}

