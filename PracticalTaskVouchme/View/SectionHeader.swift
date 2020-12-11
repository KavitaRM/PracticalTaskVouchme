//
//  SectionHeader.swift
//  PracticalTaskVouchme
//
//  Created by Kavita Malagavi on Dec-10-2020.
//

import UIKit

class SectionHeader: UIView {

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryCount: UILabel!
    
    func configure(text: String, count: Int) {
        categoryName.text = text
        categoryCount.text = "\(count) Items"
    }
    
}
