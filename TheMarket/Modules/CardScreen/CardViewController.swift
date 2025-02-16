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
        
    }
    
    // MARK: - Fields
    private let interactor: CardBusinessLogic
    private var itemCounter: Int = 0
    
    // MARK: - UI Components
    private var goBackIconButton: UIButton = UIButton(type: .system)
    private var shareIconButton: UIButton = UIButton(type: .system)
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
        configureLeftIconButton()
        configureShareIconButton()
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
    
    private func configureLeftIconButton() {
        goBackIconButton = ViewFactory.createSystemIconButton(
            with: "chevron.backward",
            configuration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium),
            tintColor: .accent
        )
        
        goBackIconButton.addTarget(self, action: #selector(goBackButtonWasTapped), for: .touchUpInside)
        
        view.addSubview(goBackIconButton)
        goBackIconButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 16)
        goBackIconButton.pinLeft(to: view, 12)
        goBackIconButton.setHeight(32)
        goBackIconButton.setWidth(32)
    }
    
    private func configureShareIconButton() {
        shareIconButton = ViewFactory.createSystemIconButton(
            with: "arrowshape.turn.up.right.fill",
            configuration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium),
            tintColor: .accent
        )
        
        shareIconButton.addTarget(
            self,
            action: #selector(shareButtonWasTapped),
            for: .touchUpInside
        )
        
        view.addSubview(shareIconButton)
        shareIconButton.pinTop(to: goBackIconButton)
        shareIconButton.pinRight(to: view, 20)
        shareIconButton.setHeight(32)
        shareIconButton.setWidth(32)
    }
    
    private func configureItemImageView() {
        asyncImageView.contentMode = .scaleAspectFit
        asyncImageView.backgroundColor = UIColor(color: .background)
        
        view.addSubview(asyncImageView)
        asyncImageView.pinTop(to: goBackIconButton.bottomAnchor, 12)
        asyncImageView.tintColor = .red
        asyncImageView.pinHorizontal(to: view)
        asyncImageView.setHeight(300)
    }
    
    private func configurePriceLabel() {
        priceLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .heading,
            textColor: .accent,
            alignment: .left,
            lines: 1
        )
        
        view.addSubview(priceLabel)
        priceLabel.pinTop(to: asyncImageView.bottomAnchor, 12)
        priceLabel.pinHorizontal(to: view, 20)
        priceLabel.setHeight(32)
    }
    
    private func configureTitleLabel() {
        titleLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .display,
            textColor: .accent,
            alignment: .left,
            lines: 0
        )
        
        view.addSubview(titleLabel)
        titleLabel.pinTop(to: priceLabel.bottomAnchor, 12)
        titleLabel.pinHorizontal(to: priceLabel)
    }
    
    private func configureCategoryLabel() {
        categoryLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .caption,
            textColor: .accent,
            alignment: .left,
            lines: 1
        )
        
        view.addSubview(categoryLabel)
        categoryLabel.pinTop(to: titleLabel.bottomAnchor, 12)
        categoryLabel.pinHorizontal(to: titleLabel)
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .paragraph,
            textColor: .secondary,
            alignment: .left,
            lines: 0
        )
        
        view.addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: categoryLabel.bottomAnchor, 12)
        descriptionLabel.pinHorizontal(to: view, 20)
    }
    
    private func configureAddToCartButton() {
        addToCartButton = ViewFactory.createButton(with: "Add to cart")
        addToCartButton.addTarget(
            self,
            action: #selector(
                addToCartButtonWasTapped
            ),
            for: .touchUpInside
        )
        
        view.addSubview(addToCartButton)
        addToCartButton.pinHorizontal(to: view, 20)
        addToCartButton.pinBottom(to: view, 80)
        addToCartButton.setHeight(48)
    }
    
    private func configureQuantityView() {
        SetActionForDecreaseButton()
        SetActionForIncreaseButton()

        
        quantityView.isHidden = true
        
        view.addSubview(quantityView)
        quantityView.pinTop(to: addToCartButton)
        quantityView.pinLeft(to: view, 20)
        quantityView.setWidth(146)
        quantityView.pinHeight(to: addToCartButton)
    }
    
    private func configureGoToCartButton() {
        goToCartButton = ViewFactory.createButton(with: "Go to cart")
        goToCartButton.isHidden = true
        
        goToCartButton.addTarget(self, action: #selector(goToCartButtonWasTapped), for: .touchUpInside)
        
        view.addSubview(goToCartButton)
        goToCartButton.pinTop(to: addToCartButton)
        goToCartButton.pinRight(to: view, 20)
        goToCartButton.pinLeft(to: quantityView.trailingAnchor, 8)
        goToCartButton.pinHeight(to: addToCartButton)
    }
    
    // MARK: - Actions
    @objc private func goBackButtonWasTapped() {
        interactor.loadItemsScreen()
    }
    
    @objc private func shareButtonWasTapped() {
        interactor.loadSharingInfo()
    }
    
    @objc private func addToCartButtonWasTapped() {
        itemCounter += 1
        quantityView.updateQuantity(counter: itemCounter)
        UIView.animate(withDuration: 0.3) { [weak self] in
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
                UIView.animate(withDuration: 0.3) { [weak self] in
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
