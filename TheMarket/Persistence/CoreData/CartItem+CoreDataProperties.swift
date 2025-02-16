//
//  CartItem+CoreDataProperties.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 16.02.2025.
//
//

import Foundation
import CoreData

@objc(CartItem)
public class CartItem: NSManagedObject { }

extension CartItem {
    @NSManaged public var id: Int16
    @NSManaged public var imageURL: String?
    @NSManaged public var payout: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var title: String?
}

extension CartItem : Identifiable { }
