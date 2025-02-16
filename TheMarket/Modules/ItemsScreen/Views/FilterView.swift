//
//  FilterView.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 12.02.2025.
//

import UIKit

final class FilterView: UIView {
    // MARK: - Constants
    enum Constants {
        static let cornerRadius: CGFloat = 10
        static let height: CGFloat = 40
        
        enum ArrowImageView {
            static let image: UIImage? = UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16))
            static let topOffset: CGFloat = 10
            static let rightOffset: CGFloat = 10
            static let height: CGFloat = 20
            static let width: CGFloat = 20
        }
        
        enum Label {
            static let lines: Int = 1
            static let topOffset: CGFloat = 10
            static let leadingOffset: CGFloat = 10
        }
    }
    
    // MARK: - Fields
    private var titleLabel: UILabel = UILabel()
    private let arrowImageView: UIImageView = UIImageView()

    var action: (() -> Void)?
    
    // MARK: - Lifycycle
    init (titleText: String) {
        super.init(frame: .zero)
        configureUI(titleText)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI
    private func configureUI(_ text: String) {
        backgroundColor = UIColor(color: .background)
        layer.cornerRadius = Constants.cornerRadius
        setHeight(Constants.height)
        
        arrowImageView.image = Constants.ArrowImageView.image
        arrowImageView.tintColor = UIColor(color: .accent)
        addSubview(arrowImageView)
        arrowImageView.pinTop(to: self, Constants.ArrowImageView.topOffset)
        arrowImageView.pinRight(to: self, Constants.ArrowImageView.rightOffset)
        arrowImageView.setHeight(Constants.ArrowImageView.height)
        arrowImageView.setWidth(Constants.ArrowImageView.width)
        
        titleLabel = ViewFactory.createLabel(
            with: text,
            textStyle: .body,
            textColor: .secondary,
            alignment: .left,
            lines: Constants.Label.lines
        )
        addSubview(titleLabel)
        titleLabel.pinLeft(to: self, Constants.Label.leadingOffset)
        titleLabel.pinTop(to: self, Constants.Label.topOffset)
        titleLabel.pinRight(to: arrowImageView.leadingAnchor)
        
        configureRecognizer()
    }
    
    private func configureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(viewWasTapped))
        addGestureRecognizer(recognizer)
    }
    
    // MARK: - Actions
    @objc private func viewWasTapped() {
        action?()
    }
    
    
}
