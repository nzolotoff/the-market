//
//  CardViewController.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//

import UIKit

final class CardViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        static let animationDuration: Double = 0.3
        
        enum asyncImageView {
            static let topOffset: CGFloat = 12
            static let height: CGFloat = 300
        }
        
        enum PriceLabel {
            static let topOffset: CGFloat = 12
            static let horizontalOffset: CGFloat = 12
            static let height: CGFloat = 32
            static let lines: Int = 1
        }
        
        enum TitleLabel {
            static let topOffset: CGFloat = 12
            static let lines: Int = 0
        }
        
        enum CategoryLabel {
            static let topOffset: CGFloat = 12
            static let lines: Int = 1
        }
        
        enum DescriptionLabel {
            static let topOffset: CGFloat = 12
            static let horizontalOffset: CGFloat = 12
            static let lines: Int = 0
        }
        
        enum AddToCartButton {
            static let title: String = "Add to shopping list"
            static let horizontalOffset: CGFloat = 12
            static let bottomOffset: CGFloat = 80
            static let height: CGFloat = 48

        }
        
        enum QuantityView {
            static let leftOffset: CGFloat = 20
            static let widthOffset: CGFloat = 146
        }
        
        enum GoToCartButton {
            static let title: String = "Go to cart"
            static let leftOffset: CGFloat = 8
            static let rightOffset: CGFloat = 20

        }
    }
    
    // MARK: - Fields
    private let interactor: CardBusinessLogic
    private var itemCounter: Int = 0
    
    // MARK: - UI Components
    private let navigationView: NavigationView = NavigationView(title: "")
    private let asyncImageView: AsyncImageView = AsyncImageView()
    private var priceLabel: UILabel = UILabel()
    private var titleLabel: UILabel = UILabel()
    private var categoryLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    private var addToCartButton: UIButton = UIButton(type: .system)
    private var goToCartButton: UIButton = UIButton(type: .system)
    private var quantityView: ItemQuantityView = ItemQuantityView()
    
    
    // MARK: - Lyfecycle
    init(interactor: CardBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.loadStart()
    }
    
    // MARK: Methods
    func displayStart(with model: CardModel) {
        asyncImageView.setImage(imageURL: model.imageURL)
        priceLabel.text = "$" + model.price
        titleLabel.text = model.title
        categoryLabel.text = "Category: " + model.category
        descriptionLabel.text = model.description
        
        view.layoutIfNeeded()
    }
    
    func displayItemSharing(_ itemsToShare: [String]) {
        let activityVC = UIActivityViewController(
            activityItems: itemsToShare,
            applicationActivities: nil
        )
        present(activityVC, animated: true)
        
        view.layoutIfNeeded()
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        configureNavigationView()
        configureItemImageView()
        configurePriceLabel()
        configureTitleLabel()
        configureCategoryLabel()
        configureDescriptionLabel()
        configureAddToCartButton()
        configureQuantityView()
        configureGoToCartButton()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureNavigationView() {
        setActionForGoBackButton()
        setActionForShareButton()
        
        view.addSubview(navigationView)
        
        navigationView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        navigationView.pinHorizontal(to: view)
        navigationView.setHeight(40)
    }
    
    private func configureItemImageView() {
        asyncImageView.contentMode = .scaleAspectFit
        asyncImageView.backgroundColor = UIColor(color: .background)
        
        view.addSubview(asyncImageView)
        asyncImageView.pinTop(
            to: navigationView.bottomAnchor,
            Constants.asyncImageView.topOffset
        )
        asyncImageView.tintColor = .red
        asyncImageView.pinHorizontal(to: view)
        asyncImageView.setHeight(Constants.asyncImageView.height)
    }
    
    private func configurePriceLabel() {
        priceLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .heading,
            textColor: .accent,
            alignment: .left,
            lines: Constants.PriceLabel.lines
        )
        
        view.addSubview(priceLabel)
        priceLabel.pinTop(
            to: asyncImageView.bottomAnchor,
            Constants.PriceLabel.topOffset
        )
        priceLabel.pinHorizontal(
            to: view,
            Constants.PriceLabel.horizontalOffset
        )
        priceLabel.setHeight(Constants.PriceLabel.height)
    }
    
    private func configureTitleLabel() {
        titleLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .display,
            textColor: .accent,
            alignment: .left,
            lines: Constants.TitleLabel.lines
        )
        
        view.addSubview(titleLabel)
        titleLabel.pinTop(
            to: priceLabel.bottomAnchor,
            Constants.TitleLabel.topOffset
        )
        titleLabel.pinHorizontal(to: priceLabel)
    }
    
    private func configureCategoryLabel() {
        categoryLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .caption,
            textColor: .accent,
            alignment: .left,
            lines: Constants.CategoryLabel.lines
        )
        
        view.addSubview(categoryLabel)
        categoryLabel.pinTop(
            to: titleLabel.bottomAnchor,
            Constants.CategoryLabel.topOffset
        )
        categoryLabel.pinHorizontal(to: titleLabel)
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .paragraph,
            textColor: .secondary,
            alignment: .left,
            lines: Constants.DescriptionLabel.lines
        )
        
        view.addSubview(descriptionLabel)
        descriptionLabel.pinTop(
            to: categoryLabel.bottomAnchor,
            Constants.DescriptionLabel.topOffset
        )
        descriptionLabel.pinHorizontal(
            to: view,
            Constants.DescriptionLabel.horizontalOffset
        )
    }
    
    private func configureAddToCartButton() {
        addToCartButton = ViewFactory.createButton(
            with: Constants.AddToCartButton.title
        )
        addToCartButton.addTarget(
            self,
            action: #selector(
                addToCartButtonWasTapped
            ),
            for: .touchUpInside
        )
        
        view.addSubview(addToCartButton)
        addToCartButton.pinHorizontal(
            to: view,
            Constants.AddToCartButton.horizontalOffset
        )
        addToCartButton.pinBottom(
            to: view,
            Constants.AddToCartButton.bottomOffset
        )
        addToCartButton.setHeight(Constants.AddToCartButton.height)
    }
    
    private func configureQuantityView() {
        SetActionForDecreaseButton()
        SetActionForIncreaseButton()

        
        quantityView.isHidden = true
        
        view.addSubview(quantityView)
        quantityView.pinTop(to: addToCartButton)
        quantityView.pinLeft(to: view, Constants.QuantityView.leftOffset)
        quantityView.setWidth(Constants.QuantityView.widthOffset)
        quantityView.pinHeight(to: addToCartButton)
    }
    
    private func configureGoToCartButton() {
        goToCartButton = ViewFactory.createButton(
            with: Constants.GoToCartButton.title
        )
        goToCartButton.isHidden = true
        
        goToCartButton.addTarget(
            self,
            action: #selector(goToCartButtonWasTapped),
            for: .touchUpInside
        )
        
        view.addSubview(goToCartButton)
        goToCartButton.pinTop(to: addToCartButton)
        goToCartButton.pinRight(to: view, Constants.GoToCartButton.rightOffset)
        goToCartButton.pinLeft(
            to: quantityView.trailingAnchor,
            Constants.GoToCartButton.leftOffset
        )
        goToCartButton.pinHeight(to: addToCartButton)
    }
    
    // MARK: - Actions
    func setActionForGoBackButton() {
        navigationView.goBackIconButtonAction = { [weak self] in
            self?.interactor.loadItemsScreen()
        }
    }
    
    func setActionForShareButton() {
        navigationView.shareIconButtonAction = { [weak self] in
            self?.interactor.loadSharingInfo()
        }
    }
    
    @objc private func addToCartButtonWasTapped() {
        itemCounter += 1
        quantityView.updateQuantity(counter: itemCounter)
        UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
            guard let self else { return }
            
            self.addToCartButton.isHidden = true
            self.goToCartButton.isHidden = false
            self.quantityView.isHidden = false
        }
    }
    
    private func SetActionForIncreaseButton() {
        quantityView.increaseButtonAction = { [weak self] in
            guard let self else { return }

            self.itemCounter += 1
            self.quantityView.updateQuantity(counter: self.itemCounter)
        }
    }
    
    private func SetActionForDecreaseButton() {
        quantityView.decreaseButtonAction = { [weak self] in
            guard let self else { return }

            self.itemCounter -= 1
            if itemCounter == 0 {
                UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
                    guard let self else { return }
                    
                    self.addToCartButton.isHidden = false
                    self.goToCartButton.isHidden = true
                    self.quantityView.isHidden = true
                }
            } else {
                self.quantityView.updateQuantity(counter: self.itemCounter)
            }
        }
    }
    
    @objc private func goToCartButtonWasTapped() {
        interactor.loadShoppingListScreen()
    }
}
