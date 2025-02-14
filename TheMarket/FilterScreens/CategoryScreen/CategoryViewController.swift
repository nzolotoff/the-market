//
//  CategoryViewController.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 14.02.2025.
//

import UIKit

final class CategoryViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        static let bottomSpace: CGFloat = 20
        enum HeaderView {
            static let leftButtonImage: UIImage? = UIImage(
                systemName: "xmark",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 14,
                    weight: .medium
                )
            )
            static let title: String = "Category"
            static let rightButtonTitle: String = "Clear"
            static let height: CGFloat = 20
            static let topOffset: CGFloat = 16

        }
        
        enum CategoriesTable {
            static let numberOfRows: Int = 5
            static let rowHeight: CGFloat = 40
            static let topOffset: CGFloat = 12
        }
        
        enum ActionButton {
            static let title: String = "Apply"
            static let topOffset: CGFloat = 12
            static let emptySpace: CGFloat = 40
            static let height: CGFloat = 48


        }
    }
    
    // MARK: - Fields
    private let interactor: CategoryBusinessLogic
    
    // MARK: - UI Components
    private let headerView: HeaderView = HeaderView(
        leftButtonImage: Constants.HeaderView.leftButtonImage,
        title: Constants.HeaderView.title,
        rightButtonTitle: Constants.HeaderView.rightButtonTitle
    )
    private let categoriesTable: UITableView = UITableView()
    private var actionButton: UIButton = UIButton(type: .system)
    
    // MARK: - Lyfecycle
    init(interactor: CategoryBusinessLogic) {
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
        calculateScreenHeight()
    }
    
    // MARK: - Private methods
    private func calculateScreenHeight() {
        let totalOffsets = Constants.HeaderView.topOffset + Constants.CategoriesTable.topOffset + Constants.ActionButton.topOffset
        let totalHeights = Constants.HeaderView.height + Constants.CategoriesTable.rowHeight * CGFloat(Constants.CategoriesTable.numberOfRows)  + Constants.ActionButton.height
        let resultHeight = totalOffsets + totalHeights + Constants.bottomSpace
        
        if let pageSheet = sheetPresentationController {
            pageSheet.detents = [.custom(resolver: { context in
                return resultHeight
            })]
        }
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        view.backgroundColor = .white
        configureHeaderView()
        configureCategoriesTable()
        configureActionButton()
    }
    
    private func configureHeaderView() {
        setActionForLeftButton()
        
        view.addSubview(headerView)
        headerView.pinHorizontal(to: view)
        headerView.pinTop(to: view, Constants.HeaderView.topOffset)
        headerView.setHeight(Constants.HeaderView.height)
    }
    
    private func configureCategoriesTable() {
        categoriesTable.dataSource = self
        categoriesTable.delegate = self
        categoriesTable.separatorStyle = .none
        categoriesTable.backgroundColor = .white
        categoriesTable.register(
            CategoryCell.self,
            forCellReuseIdentifier: CategoryCell.reuseIdentifier
        )
        
        view.addSubview(categoriesTable)
        categoriesTable.pinTop(
            to: headerView.bottomAnchor,
            Constants.CategoriesTable.topOffset
        )
        categoriesTable.pinHorizontal(to: view)
        categoriesTable.setHeight(
            CGFloat(Constants.CategoriesTable.numberOfRows) * Constants.CategoriesTable.rowHeight
        )
    }
    
    private func configureActionButton() {
        actionButton = ViewFactory.createButton(
            with: Constants.ActionButton.title
        )
        actionButton.addTarget(
            self,
            action: #selector(ActionButtonWasTapped),
            for: .touchUpInside
        )
        
        view.addSubview(actionButton)
        actionButton.pinTop(
            to: categoriesTable.bottomAnchor,
            Constants.ActionButton.topOffset
        )
        actionButton.pinCenterX(to: view)
        actionButton.setWidth(view.bounds.width - Constants.ActionButton.emptySpace)
        actionButton.setHeight(Constants.ActionButton.height)
    }
    
    // MARK: - Actions
    private func setActionForLeftButton() {
        headerView.leftButtonAction = { [weak self] in
            self?.interactor.loadCloseScreen()
        }
    }
    
    private func setActionForRightButton() {
        headerView.rightButtonAction = {
        }
    }
    
    @objc private func ActionButtonWasTapped() {
        interactor.loadCloseScreen()
    }
}


// MARK: - UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        Constants.CategoriesTable.numberOfRows
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = categoriesTable.dequeueReusableCell(
            withIdentifier: CategoryCell.reuseIdentifier,
            for: indexPath
        )
        guard let categoryCell = cell as? CategoryCell else { return cell }
        
        categoryCell.configure(
            with: CategoryModel(
                title: "Clothes",
                isSelected: false
            )
        )
        
        return categoryCell
    }
}

// MARK: - UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        Constants.CategoriesTable.rowHeight
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        categoriesTable.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryCell else {
            return
        }
        
        cell.updateCheckBoxState()
    }
}
