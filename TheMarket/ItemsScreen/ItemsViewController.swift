//
//  ViewController.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 11.02.2025.
//

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
            static let topOffset: CGFloat = 12
            static let leadingOffset: CGFloat = 20
            static let trailingOffset: CGFloat = 65
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
        
        enum FilterStack {
            static let spacing: CGFloat = 8
            static let topOffset: CGFloat = 16
            static let horizontalOffset: CGFloat = 20
        }
    }
    
    // MARK: - Fileds
    private let interactor: ItemsBusinessLogic
    
    // MARK: - UI Components
    private var searchTexfField: UITextField = UITextField()
    private let cartButton: UIButton = UIButton(type: .system)
    private let contentView: UIView = UIView()
    private let categoryFilter: FilterView = FilterView(titleText: "Category")
    private let priceFilter: FilterView = FilterView(titleText: "Price")
    private let filterStack: UIStackView = UIStackView()
    
    // MARK: - Lyfecycle
    init(interactor: ItemsBusinessLogic) {
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
    
    // MARK: - Configure UI
    private func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        configureSearchTextField()
        configureContentView()
        configureCartButton()
        configureFiltersStack()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureSearchTextField() {
        searchTexfField = ViewFactory.createTextfield(with: Constants.SearchTextField.placeholder)
        searchTexfField.leftView = UIView(frame: Constants.SearchTextField.leftViewRect)
        searchTexfField.leftViewMode = .always
        
        let searchImageView: UIImageView = UIImageView(frame: Constants.SearchTextField.leftImageViewRect)
        searchImageView.contentMode = .scaleAspectFit
        searchImageView.tintColor = UIColor(color: .secondary)
        searchImageView.image = Constants.SearchTextField.searchIcon
        searchTexfField.leftView?.addSubview(searchImageView)
        
        view.addSubview(searchTexfField)
        searchTexfField.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.SearchTextField.topOffset)
        searchTexfField.pinLeft(to: view, Constants.SearchTextField.leadingOffset)
        searchTexfField.pinRight(to: view, Constants.SearchTextField.trailingOffset)
        searchTexfField.setHeight(Constants.SearchTextField.height)
    }
    
    private func configureCartButton() {
        cartButton.setImage(Constants.CartButton.image, for: .normal)
        cartButton.tintColor = UIColor(color: .accent)
        
        view.addSubview(cartButton)
        cartButton.pinLeft(to: searchTexfField.trailingAnchor, Constants.CartButton.leadingOffset)
        cartButton.pinTop(to: searchTexfField.topAnchor, Constants.CartButton.topOffset)
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
        
        contentView.addSubview(filterStack)
        filterStack.pinTop(to: contentView.topAnchor, Constants.FilterStack.topOffset)
        filterStack.pinHorizontal(to: contentView, Constants.FilterStack.horizontalOffset)
    }
}
