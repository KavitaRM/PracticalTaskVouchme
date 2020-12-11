//
//  CustomExpandedCell.swift
//  PracticalTaskVouchme
//
//  Created by Kavita Malagavi on Dec-10-2020.
//

import UIKit

protocol UpdateCartCountDelegate: class {
    func updateCount(with count: Int)
}

class CustomExpandedCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    var counter = 0
    
    weak var delegate: UpdateCartCountDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    @IBAction func addAction(_ sender: Any) {
        counter = counter + 1
//        let dataToSend = ["name" : productPrice.text ?? "", "count" : counter] as [String : Any]
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataToLoad"), object: dataToSend)

//        self.delegate?.updateCount(with: counter)
    }
}
