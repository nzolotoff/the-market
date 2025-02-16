//
//  PriceViewController.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 14.02.2025.
//

import UIKit

final class PriceViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        enum HeaderView {
            static let leftButtonImage: UIImage? = UIImage(
                systemName: "xmark",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 14,
                    weight: .medium
                )
            )
            static let title: String = "Price, $"
            static let rightButtonTitle: String = "Reset"
            static let height: CGFloat = 20
            static let topOffset: CGFloat = 16
        }
        
        enum MinPriceTextField {
            static let title: String = "from"
            static let topOffset: CGFloat = 18
            static let leftOffset: CGFloat = 20
            static let height: CGFloat = 40
            static let emptySpace: CGFloat = 48
            static let leftViewFrame: CGRect = CGRect(
                x: 0,
                y: 0,
                width: 12,
                height: 12
            )
        }
        
        enum MaxPriceTextField {
            static let title: String = "to"
            static let leftOffset: CGFloat = 8
            static let leftViewFrame: CGRect = CGRect(
                x: 0,
                y: 0,
                width: 12,
                height: 12
            )
        }
        
        enum ActionButton {
            static let title: String = "Apply"
            static let topOffset: CGFloat = 20
            static let emptySpace: CGFloat = 40
            static let height: CGFloat = 48
        }
    }
    
    // MARK: - Fields
    private let interactor: PriceBusinessLogic
    
    // MARK: - UI Components
    private let headerView: HeaderView = HeaderView(
        leftButtonImage: Constants.HeaderView.leftButtonImage,
        title: Constants.HeaderView.title,
        rightButtonTitle: Constants.HeaderView.rightButtonTitle
    )
    private var minPriceTextField: UITextField = UITextField()
    private var maxPriceTextField: UITextField = UITextField()
    private var actionButton: UIButton = UIButton(type: .system)
    
    // MARK: - Lyfecycle
    init(interactor: PriceBusinessLogic) {
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
        configureScreenHeight()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        minPriceTextField.becomeFirstResponder()
    }
    
    // MARK: Configure Screen Height
    private func configureScreenHeight() {
        let totalOffsets = Constants.HeaderView.topOffset + Constants.MinPriceTextField.topOffset + Constants.ActionButton.topOffset
        let totalHeights = Constants.HeaderView.height + Constants.MinPriceTextField.height + Constants.ActionButton.height
        let resultHeight = totalOffsets + totalHeights
        
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
        configureMinPriceTextField()
        configureMaxPriceTextField()
        configureActionButton()
    }
    
    private func configureHeaderView() {
        setActionForleftButton()
        setActionForRightButton()
        
        view.addSubview(headerView)
        headerView.pinHorizontal(to: view)
        headerView.pinTop(to: view, Constants.HeaderView.topOffset)
        headerView.setHeight(Constants.HeaderView.height)
    }
    
    private func configureMinPriceTextField() {
        minPriceTextField = ViewFactory.createTextfield(
            with: Constants.MinPriceTextField.title,
            textColor: .accent
        )
        minPriceTextField.keyboardType = .numberPad
        minPriceTextField.leftView = UIView(frame: Constants.MinPriceTextField.leftViewFrame)
        minPriceTextField.leftViewMode = .always
        
        view.addSubview(minPriceTextField)
        minPriceTextField.pinTop(
            to: headerView.bottomAnchor,
            Constants.MinPriceTextField.topOffset
        )
        minPriceTextField.pinLeft(to: view, Constants.MinPriceTextField.leftOffset)
        minPriceTextField.setHeight(Constants.MinPriceTextField.height)
        minPriceTextField.setWidth(
            (
                view.bounds.width - CGFloat(Constants.MinPriceTextField.emptySpace)
            ) / CGFloat(2)
        )
    }
    
    private func configureMaxPriceTextField() {
        maxPriceTextField = ViewFactory.createTextfield(
            with: Constants.MaxPriceTextField.title,
            textColor: .accent
        )
        maxPriceTextField.keyboardType = .numberPad
        maxPriceTextField.leftView = UIView(frame: Constants.MaxPriceTextField.leftViewFrame)
        maxPriceTextField.leftViewMode = .always
        
        view.addSubview(maxPriceTextField)
        maxPriceTextField.pinTop(to: minPriceTextField)
        maxPriceTextField.pinLeft(
            to: minPriceTextField.trailingAnchor,
            Constants.MaxPriceTextField.leftOffset
        )
        maxPriceTextField.pinWidth(to: minPriceTextField)
        maxPriceTextField.pinHeight(to: minPriceTextField)
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
            to: minPriceTextField.bottomAnchor,
            Constants.ActionButton.topOffset
        )
        actionButton.pinCenterX(to: view)
        actionButton.setWidth(view.bounds.width - Constants.ActionButton.emptySpace)
        actionButton.setHeight(Constants.ActionButton.height)
    }
    
    // MARK: - Actions
    @objc private func ActionButtonWasTapped() {
        interactor.loadCloseScreen()
    }
    
    private func setActionForleftButton() {
        headerView.leftButtonAction = { [weak self] in
            self?.interactor.loadCloseScreen()
        }
    }
    
    private func setActionForRightButton() {
        headerView.rightButtonAction = { [weak self] in
            self?.minPriceTextField.text = nil
            self?.maxPriceTextField.text = nil
        }
    }
}
