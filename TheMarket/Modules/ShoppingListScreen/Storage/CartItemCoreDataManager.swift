//
//  CartItemCoreDataManager.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//


import Foundation
import UIKit
import CoreData

public final class CartItemCoreDataManager: CartItemCoreDataManagerLogic {
    // MARK: - Constants
    enum Constants {
        static let entityName: String = "CartItem"
    }
    
    // MARK: - Singleton
    public static let shared = CartItemCoreDataManager()
    private init() { }
    
    // MARK: - Variables
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistenceContainer.viewContext
    }
    
    // MARK: CRUD Methods
    func createCartItem(with model: CartItemModel) throws {
        guard let cartItemDescription = NSEntityDescription.entity(
            forEntityName: Constants.entityName,
            in: context
        ) else {
            throw CartItemManagerError.entityNotFound
        }
        
        let product = CartItem(entity: cartItemDescription, insertInto: context)
        product.id = Int16(model.id)
        product.imageURL = model.imageURL
        product.title = model.title
        product.payout = model.payout
        product.quantity = Int16(model.quantity)
        
        appDelegate.saveContext()
    }
    
    func fetchCartItems() -> Result<[CartItemModel], CartItemManagerError> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        
        if let cartItems = try? context.fetch(fetchRequest) as? [CartItemModel] {
            return .success(cartItems)
        } else {
            return .failure(.listOfItemsNotFound)
        }
    }
}
