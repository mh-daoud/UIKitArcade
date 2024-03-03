//
//  ShoppingItem.swift
//  Challenge32
//
//  Created by Mac on 03/03/2024.
//

import Foundation

struct ShoppingItem : Codable  {
    
    static let shoppingListKey = "shopping_list_key"

    var id: Int
    var name: String
    var quantity: Int
    var description: String?
}
