//
//  ViewController.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 11.02.2025.
//

import Foundation
import UIKit

final class ItemsViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        enum SearchTextField {
            static let placeholder: String = "Search"
            static let leftViewRect: CGRect = CGRect(x: 0, y: 0, width: 36, height: 16)
            static let leftImageViewRect: CGRect = CGRect(x: 12, y: 0, width: 18, height: 18)
            static let searchIcon: UIImage? = UIImage(
                systemName: "magnifyingglass",
                withConfiguration: UIImage.SymbolConfiguration(weight: .medium)
            )
            static let animationDuration: CGFloat = 0.3
            static let defaultDecrement: CGFloat = 85
            static let focusedDecrement: CGFloat = 120
            static let topOffset: CGFloat = 12
            static let leadingOffset: CGFloat = 20
            static let height: CGFloat = 40
        }
        
        enum CartButton {
            static let image: UIImage? = UIImage(
                systemName: "cart",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)
            )
            static let topOffset: CGFloat = 8
            static let leadingOffset: CGFloat = 12
        }
        
        enum CancelButton {
            static let title: String = "Cancel"
            static let topOffset: CGFloat = 7
            static let leadingOffset: CGFloat = 24
        }
        
        enum FilterStack {
            static let spacing: CGFloat = 8
            static let topOffset: CGFloat = 16
            static let horizontalOffset: CGFloat = 20
        }
        
        enum ItemsCollection {
            static let contentInset: UIEdgeInsets = UIEdgeInsets(
                top: 16,
                left: 20,
                bottom: 16,
                right: 20
            )
            static let cellHeight: CGFloat = 180
            static let itemSpacing: CGFloat = 16
            static let lineSpacing: CGFloat = 24
            static let topOffset: CGFloat = 4
        }
        
        enum SearchHistoryTable {
            static let topOffset: CGFloat = 20
            static let rowHeight: CGFloat = 40
        }
    }
    
    // MARK: - Fileds
    private let interactor: ItemsBusinessLogic & ItemsDataStore
    
    // MARK: - UI Components
    private var searchTexfField: UITextField = UITextField()
    private var searchTextFieldWidthConstraint: NSLayoutConstraint?
    private let cartButton: UIButton = UIButton(type: .system)
    private let contentView: UIView = UIView()
    private let categoryFilter: FilterView = FilterView(titleText: "Category")
    private let priceFilter: FilterView = FilterView(titleText: "Price")
    private let filterStack: UIStackView = UIStackView()
    private let cancelButton: UIButton = UIButton(type: .system)
    private let itemsCollection: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private let searchHistoryTable: UITableView = UITableView()
    private var loadingIndicator: UIActivityIndicatorView?
    
    // MARK: - Lyfecycle
    init(interactor: ItemsBusinessLogic & ItemsDataStore) {
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
        showLoadingIndicator()
        interactor.loadStart()
    }
    
    // MARK: - Methods
    func displayStart() {
        itemsCollection.reloadData()
    }
    
    func displayError(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoadingIndicator()
            
            let errorView = ErrorStateView(title: error.localizedDescription)
            errorView.buttonAction = { [weak self] in
                self?.showLoadingIndicator()
                self?.interactor.loadNewItems()
            }
            guard let self else { return }
            self.view.addSubview(errorView)
            errorView.pinTop(to: self.filterStack.bottomAnchor)
            errorView.pinHorizontal(to: self.view)
            errorView.pinBottom(to: self.view)
            
            self.view.layoutIfNeeded()
        }
    }
    
    func showLoadingIndicator() {
        if loadingIndicator == nil {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.center.x = self.view.center.x
            indicator.center.y = 210
            indicator.startAnimating()
            self.view.addSubview(indicator)
            self.loadingIndicator = indicator
        }
    }
    
    func hideLoadingIndicator() {
        guard let indicator = loadingIndicator else { return }
        
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        loadingIndicator = nil
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        configureSearchTextField()
        configureCancelButton()
        configureContentView()
        configureCartButton()
        configureFiltersStack()
        configureItemsCollection()
        configureSearchHistoryTable()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureSearchTextField() {
        searchTexfField = ViewFactory.createTextfield(with: Constants.SearchTextField.placeholder)
        searchTexfField.leftView = UIView(frame: Constants.SearchTextField.leftViewRect)
        searchTexfField.leftViewMode = .always
        searchTexfField.keyboardType = .webSearch
        searchTexfField.delegate = self
        
        let searchImageView: UIImageView = UIImageView(frame: Constants.SearchTextField.leftImageViewRect)
        searchImageView.contentMode = .scaleAspectFit
        searchImageView.tintColor = UIColor(color: .secondary)
        searchImageView.image = Constants.SearchTextField.searchIcon
        searchTexfField.leftView?.addSubview(searchImageView)
        
        view.addSubview(searchTexfField)
        searchTexfField.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.SearchTextField.topOffset)
        searchTexfField.pinLeft(to: view, Constants.SearchTextField.leadingOffset)
        searchTexfField.setHeight(Constants.SearchTextField.height)
        
        searchTextFieldWidthConstraint = searchTexfField.widthAnchor.constraint(
            equalToConstant: view.frame.width - Constants.SearchTextField.defaultDecrement
        )
        searchTextFieldWidthConstraint?.isActive = true
        
    }
    
    private func configureCartButton() {
        cartButton.setImage(Constants.CartButton.image, for: .normal)
        cartButton.tintColor = UIColor(color: .accent)
        cartButton.addTarget(self, action: #selector(cartButtonWasTapped), for: .touchUpInside)
        
        view.addSubview(cartButton)
        cartButton.pinLeft(to: searchTexfField.trailingAnchor, Constants.CartButton.leadingOffset)
        cartButton.pinTop(to: searchTexfField.topAnchor, Constants.CartButton.topOffset)
    }
    
    private func configureCancelButton() {
        cancelButton.backgroundColor = .clear
        cancelButton.setTitle(Constants.CancelButton.title, for: .normal)
        cancelButton.setTitleColor(UIColor(color: .buttonMinoryText), for: .normal)
        cancelButton.isHidden = true
        cancelButton.addTarget(self, action: #selector(cancelButtonWasTapped), for: .touchUpInside)
        
        view.addSubview(cancelButton)
        cancelButton.pinTop(to: searchTexfField, Constants.CancelButton.topOffset)
        cancelButton.pinLeft(to: searchTexfField.trailingAnchor, Constants.CancelButton.leadingOffset)
    }
    
    private func configureContentView() {
        view.addSubview(contentView)
        contentView.pinTop(to: searchTexfField.bottomAnchor)
        contentView.pinHorizontal(to: view)
        contentView.pinBottom(to: view.bottomAnchor)
    }
    
    private func configureFiltersStack() {
        filterStack.axis = .horizontal
        filterStack.distribution = .fillEqually
        filterStack.spacing = Constants.FilterStack.spacing
        filterStack.addArrangedSubviews(categoryFilter, priceFilter)
        
        setActionForCategoryFilter()
        setActionForPriceFilter()
        
        contentView.addSubview(filterStack)
        filterStack.pinTop(to: contentView.topAnchor, Constants.FilterStack.topOffset)
        filterStack.pinHorizontal(to: contentView, Constants.FilterStack.horizontalOffset)
    }
    
    private func configureItemsCollection() {
        itemsCollection.dataSource = interactor
        itemsCollection.delegate = self
        itemsCollection.backgroundColor = .white
        itemsCollection.alwaysBounceVertical = true
        itemsCollection.showsVerticalScrollIndicator = true
        itemsCollection.contentInset = Constants.ItemsCollection.contentInset
        itemsCollection.register(
            ItemCell.self,
            forCellWithReuseIdentifier: ItemCell.reuseIdentifier
        )
        
        if let layout = itemsCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = Constants.ItemsCollection.itemSpacing
            layout.minimumLineSpacing = Constants.ItemsCollection.lineSpacing
            
            layout.invalidateLayout()
        }
        
        contentView.addSubview(itemsCollection)
        itemsCollection.pinTop(to: filterStack.bottomAnchor, Constants.ItemsCollection.topOffset)
        itemsCollection.pinHorizontal(to: contentView)
        itemsCollection.pinBottom(to: contentView)
    }
    
    private func configureSearchHistoryTable() {
        searchHistoryTable.backgroundColor = .white
        searchHistoryTable.separatorStyle = .none
        searchHistoryTable.dataSource = self
        searchHistoryTable.delegate = self
        searchHistoryTable.register(
            SearchHistoryCell.self,
            forCellReuseIdentifier: SearchHistoryCell.reuseIdentifier
        )
        
        searchHistoryTable.isHidden = true
        
        view.addSubview(searchHistoryTable)
        searchHistoryTable.pinTop(
            to: searchTexfField.bottomAnchor,
            Constants.SearchHistoryTable.topOffset
        )
        searchHistoryTable.pinHorizontal(to: view)
        searchHistoryTable.pinBottom(to: view)
    }
    
    // MARK: - Actions
    private func defaultState() {
        cartButton.isHidden = false
        contentView.isHidden = false
        
        cancelButton.isHidden = true
        searchHistoryTable.isHidden = true
    }
    
    @objc private func cartButtonWasTapped() {
        interactor.loadShoppingListScreen()
    }
    
    @objc private func cancelButtonWasTapped() {
        let defaultWidth = view.frame.width - Constants.SearchTextField.defaultDecrement
        animateTextFieldWidth(to: defaultWidth)
        searchTexfField.resignFirstResponder()
        searchTexfField.text = nil

        defaultState()
    }
    
    private func setActionForCategoryFilter() {
        categoryFilter.action = { [weak self] in
            self?.interactor.loadCategoryFilterScreen()
        }
    }
    
    private func setActionForPriceFilter() {
        priceFilter.action = { [weak self] in
            self?.interactor.loadPriceFilterScreen()
        }
    }
    
    // MARK: - Animations
    private func animateTextFieldWidth(to newWidth: CGFloat) {
        UIView.animate(
            withDuration: Constants.SearchTextField.animationDuration,
            animations: { [weak self] in
            self?.searchTextFieldWidthConstraint?.constant = newWidth
            self?.view?.layoutIfNeeded()
        })
    }
}

// MARK: - UITextFieldDelegate
extension ItemsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        interactor.loadItems(with: text)
        textField.resignFirstResponder()
        defaultState()
        animateTextFieldWidth(to: view.bounds.width - Constants.SearchTextField.defaultDecrement)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let newWidth = view.bounds.width - Constants.SearchTextField.focusedDecrement
        animateTextFieldWidth(to: newWidth)
        cartButton.isHidden = true
        contentView.isHidden = true
        
        cancelButton.isHidden = false
        searchHistoryTable.isHidden = false
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: (itemsCollection.bounds.width - 56) / 2, height: Constants.ItemsCollection.cellHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        interactor.loadCardScreen(for: indexPath.row)
    }
}

// MARK: - UITableViewDataSource
extension ItemsViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        1
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = searchHistoryTable.dequeueReusableCell(
            withIdentifier: SearchHistoryCell.reuseIdentifier,
            for: indexPath
        )
        guard let searchHistoryCell = cell as? SearchHistoryCell else { return cell }
        
        searchHistoryCell.configure(
            with: Items.SearchQueryViewModel(query: "Denim Jacket")
        )
        return searchHistoryCell
    }
}

// MARK: - UITableViewDelegate
extension ItemsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        Constants.SearchHistoryTable.rowHeight
    }
}
