//
//  ShoppingListViewController.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//
import UIKit

final class ShoppingListViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        
    }
    
    // MARK: - Fields
    private let interactor: ShoppingListBusinessLogic
    
    // MARK: - UI Components
    private let navigationView: NavigationView = NavigationView(title: "Shopping list")
    private var quantityLabel: UILabel = UILabel()
    private var clearAllButton: UIButton = UIButton(type: .system)
    private let itemsTableView: UITableView = UITableView()
    
    // MARK: - Lyfecycle
    init(interactor: ShoppingListBusinessLogic) {
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
    func displayStart(_ itemsCounter: Int) {
        itemsTableView.reloadData()
        quantityLabel.text = "\(itemsCounter)" + " items"
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        view.backgroundColor = .white
        configureNavigationView()
        configureItemsLabel()
        configureClearAllButton()
        configureItemsTableView()
        
    }
    
    private func configureNavigationView() {
        setActionForGoBackButton()
        setActionForShareButton()
        
        view.addSubview(navigationView)
        
        navigationView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        navigationView.pinHorizontal(to: view)
        navigationView.setHeight(40)
    }
    
    private func configureItemsLabel() {
        quantityLabel = ViewFactory.createLabel(
            with: "",
            textStyle: .body,
            textColor: .accent,
            alignment: .left,
            lines: 1
        )
        
        view.addSubview(quantityLabel)
        quantityLabel.pinTop(to: navigationView.bottomAnchor, 30)
        quantityLabel.pinLeft(to: view, 20)
    }
    
    private func configureClearAllButton() {
        clearAllButton.setTitle("Clear All", for: .normal)
        clearAllButton.setTitleColor(UIColor(color: .distructive), for: .normal)
        clearAllButton.backgroundColor = .clear
        clearAllButton.addTarget(
            self,
            action: #selector(clearAllButtonWasTapped),
            for: .touchUpInside
        )
        
        view.addSubview(clearAllButton)
        clearAllButton.pinTop(to: quantityLabel)
        clearAllButton.pinRight(to: view, 20)
    }
    
    private func configureItemsTableView() {
        itemsTableView.backgroundColor = .clear
        itemsTableView.separatorStyle = .none
        itemsTableView.dataSource = interactor
        itemsTableView.delegate = self
        
        itemsTableView.register(
            ItemCartCell.self,
            forCellReuseIdentifier: ItemCartCell.reuseIdentifier
        )
        
        view.addSubview(itemsTableView)
        itemsTableView.pinTop(to: clearAllButton.bottomAnchor, 20)
        itemsTableView.pinHorizontal(to: view)
        itemsTableView.pinBottom(to: view)
    }
    
    // MARK: - Actions
    @objc private func clearAllButtonWasTapped() {
        
    }
    
    private func setActionForGoBackButton() {
        navigationView.goBackIconButtonAction = { [weak self] in
            guard let self else { return }
            interactor.loadPreviousScreen()
        }
    }
    
    private func setActionForShareButton() {
        navigationView.shareIconButtonAction = { [weak self] in
            guard let self else { return }
            interactor.loadSharingInfo()
        }
    }
}


// MARK: - UITableViewDelegate
extension ShoppingListViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 100
    }
}
