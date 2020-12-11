//
//  ProductModel.swift
//  PracticalTaskVouchme
//
//  Created by Kavita Malagavi on Dec-9-2020.
//

import Foundation

struct ProductModel: Codable {
    let method: String?
    let dataArr: [DataModel]?
    
    private enum CodingKeys: String, CodingKey {
        case dataArr = "data"
        case method
    }
}

struct DataModel: Codable {
    let subCategories: [Subcategories]?
    let categoryName: String?
    let totalItems: Int?
    
    private enum CodingKeys: String, CodingKey {
        case subCategories = "subcategories"
        case categoryName = "cat_name"
        case totalItems = "total_items"
    }
}

struct Subcategories: Codable {
    let subCategoryName: String?
    let products: [Products]?
    let totalItems: Int?
    
    private enum CodingKeys: String, CodingKey {
        case subCategoryName = "sub_cat_name"
        case totalItems = "total_items"
        case products
    }
}

struct Products: Codable {
    let name: String?
    let productId: Int?
    let categoryId: Int?
    let subCategoryId:Int?
    let imageUrl: String?
    let price: String?
    let description: String?

    private enum CodingKeys: String, CodingKey {
        case productId = "id"
        case categoryId = "category_id"
        case subCategoryId = "sub_category_id"
        case imageUrl = "image"
        case description = "short_description"
        case name,price
    }
}
