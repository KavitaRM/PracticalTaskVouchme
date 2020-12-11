//
//  ExpandedTableViewCell.swift
//  PracticalTaskVouchme
//
//  Created by Kavita Malagavi on Dec-10-2020.
//

import UIKit

protocol ExpandedCellDelegate {
    func valueSelected(value: AnyObject)
    func closeDropDown()

}

class ExpandedTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var expandedTableview: UITableView!

    var dataSourceArray:[Products] = Array()
    var subcategoryName : String?
    var delegate: ExpandedCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        expandedTableview.register(UINib(nibName: "CustomExpandedCell", bundle: nil), forCellReuseIdentifier: "customExpandedCell")
        expandedTableview.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        expandedTableview.delegate = self
        expandedTableview.dataSource = self
        expandedTableview.tableFooterView = UIView()
    }

    //MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
            cell.productSubcategory.text = subcategoryName
            cell.itemCount.isHidden = true
            cell.productDescriprion.isHidden = true
        
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customExpandedCell") as! CustomExpandedCell
            cell.productDescription.text = dataSourceArray[indexPath.row-1].description
            cell.productPrice.text =  dataSourceArray[indexPath.row-1].price
            cell.productName.text = dataSourceArray[indexPath.row-1].name
        
            let url = URL(string: dataSourceArray[indexPath.row-1].imageUrl!)
            let data = try? Data(contentsOf: url!)
            cell.productImage.image = UIImage(data: data!)

            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        } else {
            return 100
        }
    }
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            if delegate != nil {
                delegate.closeDropDown()
            }

        } else {
            if delegate != nil {
                delegate.valueSelected(value: dataSourceArray[indexPath.row] as AnyObject)
            }
        }
        
    }

    
}
