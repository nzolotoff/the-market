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
    private let headerView: HeaderView = HeaderView(leftButtonImage: UIImage(systemName: "chevron.backward"), title: "Shopping list", rightButtonTitle: "arrowshape.turn.up.right.fill")
    
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
    func displayStart() {
        
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureHeaderView() {
        view.addSubview(headerView)
        
        headerView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        headerView.pinHorizontal(to: view)
    }
}
