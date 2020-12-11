//
//  ProductViewModel.swift
//  PracticalTaskVouchme
//
//  Created by Kavita Malagavi on Dec-9-2020.
//w

import Foundation
import UIKit

class ProductViewModel: NSObject {
    var productList : ProductModel?
    private var datamodel = [DataModel]()
    private var subCategories = [Subcategories]()

    var reloadSections: ((_ section: Int) -> Void)?

    func fetchproducts(successCallback : @escaping () -> Void, failureCallback: @escaping () -> Void) {
        NetworkManager.shared.getProducts {[weak self] (response, errorString) -> Void in
            guard let weakSelf = self else { return }
            if let response = response {
                weakSelf.productList = response
            
                successCallback()
            } else {
                failureCallback()
            }
        }
    }

    func productsCount(index: Int) -> Int {
        return self.productList?.dataArr?[index].subCategories?.count ?? 0
    }

    func getSubcategoryForIndex(index: IndexPath) -> String {
        return self.productList?.dataArr?[index.section].subCategories?[index.row].subCategoryName ?? ""
    }
    
    func getTotalItemForIndex(index: IndexPath) -> Int {
        return self.productList?.dataArr?[index.section].subCategories?[index.row].totalItems ?? 0
    }
    
    func getCategoryCount() -> Int {
        return self.productList?.dataArr?.count ?? 0
    }
    
    func getCategoryNameForSection(index: Int) -> String {
        return self.productList?.dataArr?[index].categoryName ?? ""
    }
    
    func getItemCountForSection(index: Int) -> Int {
        return self.productList?.dataArr?[index].totalItems ?? 0
    }
    
    func getData() -> [DataModel]? {
        return self.datamodel
    }
}
