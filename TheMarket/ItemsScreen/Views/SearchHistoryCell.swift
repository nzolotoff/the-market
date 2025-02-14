//
//  SearchCell.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 13.02.2025.
//

import UIKit

final class SearchHistoryCell: UITableViewCell {
    // MARK: - Constants
    enum Constants {
        static let reuseIdentifier: String = "SearchHistoryCell"
        
        enum LeftIconImageView {
            static let image: UIImage? = UIImage(
                systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 16,
                    weight: .medium
                )
            )
            static let TopOffset: CGFloat = 8.5
            static let LeadingOffset: CGFloat = 12
            static let width: CGFloat = 20
            static let height: CGFloat = 20
        }
        
        enum RightIconImageView {
            static let image: UIImage? = UIImage(
                systemName: "chevron.right",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 16,
                    weight: .medium
                )
            )
            static let TrailingOffset: CGFloat = 20
            static let width: CGFloat = 12
            static let height: CGFloat = 18
        }
        
        enum QueryLabel {
            static let TopOffset: CGFloat = 8
            static let LeadingOffset: CGFloat = 20
            static let TrailingOffset: CGFloat = 20
            static let lines: Int = 1
        }
        
        enum DividerView {
            static let height: CGFloat = 1
        }
    }
    
    // MARK: - Fields
    static let reuseIdentifier: String = Constants.reuseIdentifier
    private let wrapView: UIView = UIView()
    private let leftIconImageView: UIImageView = UIImageView()
    private var queryLabel: UILabel = UILabel()
    private let rightIconImageView: UIImageView = UIImageView()
    private let dividerView: UIView = UIView()
    
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
    func configure(with model: SearchQueryModel) {
        queryLabel.text = model.query
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        configureWrapView()
        configureLeftIconImageView()
        configureRightIconImageView()
        configureQueryLabel()
        configureDividerView()
    }
    
    private func configureWrapView() {
        wrapView.backgroundColor = .white
        
        addSubview(wrapView)
        wrapView.pin(to: self)
    }
    
    private func configureLeftIconImageView() {
        leftIconImageView.image = Constants.LeftIconImageView.image
        leftIconImageView.tintColor = UIColor(color: .accent)
    
        wrapView.addSubview(leftIconImageView)
        leftIconImageView.pinTop(to: wrapView, Constants.LeftIconImageView.TopOffset)
        leftIconImageView.pinLeft(to: wrapView, Constants.LeftIconImageView.LeadingOffset)
        leftIconImageView.setHeight(Constants.LeftIconImageView.height)
        leftIconImageView.setWidth(Constants.LeftIconImageView.width)
    }
    
    private func configureRightIconImageView() {
        rightIconImageView.image = Constants.RightIconImageView.image
        rightIconImageView.tintColor = UIColor(color: .accent)
        
        wrapView.addSubview(rightIconImageView)
        
        rightIconImageView.pinTop(to: leftIconImageView)
        rightIconImageView.pinRight(to: wrapView, Constants.RightIconImageView.TrailingOffset)
        rightIconImageView.setHeight(Constants.RightIconImageView.height)
        rightIconImageView.setWidth(Constants.RightIconImageView.width)
    }
    
    private func configureQueryLabel() {
        queryLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .paragraphSmall,
            textColor: .accent,
            alignment: .left,
            lines: Constants.QueryLabel.lines
        )
        wrapView.addSubview(queryLabel)
        queryLabel.pinTop(to: wrapView, Constants.QueryLabel.TopOffset)
        queryLabel.pinLeft(to: leftIconImageView.trailingAnchor, Constants.QueryLabel.LeadingOffset)
        queryLabel.pinRight(to: rightIconImageView.leadingAnchor, Constants.QueryLabel.TrailingOffset)
    }
    
    private func configureDividerView() {
        dividerView.backgroundColor = UIColor(color: .background)
        
        wrapView.addSubview(dividerView)
        dividerView.pinRight(to: wrapView)
        dividerView.pinBottom(to: wrapView)
        dividerView.setHeight(Constants.DividerView.height)
        dividerView.pinLeft(to: queryLabel)
    }
}
