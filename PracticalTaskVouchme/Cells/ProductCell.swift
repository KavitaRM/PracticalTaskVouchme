//
//  ProductCell.swift
//  PracticalTaskVouchme
//
//  Created by Kavita Malagavi on Dec-9-2020.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet var productSubcategory: UILabel!
    @IBOutlet var itemCount: UILabel!
    @IBOutlet var productDescriprion: UILabel!
    
    var productViewModel = ProductViewModel()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(index: IndexPath) {
        productSubcategory.text = productViewModel.getSubcategoryForIndex(index: index)
    }
    
}
