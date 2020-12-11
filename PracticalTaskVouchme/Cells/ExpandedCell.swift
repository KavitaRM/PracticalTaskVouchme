//
//  ExpandedCell.swift
//  ExpandableTable
//
//  Created by Aman Aggarwal on 3/23/17.
//  Copyright © 2017 iostutorialjunction.com. All rights reserved.
//

import UIKit

protocol ExpandedCellDelegate {
    func valueSelected(value: AnyObject)
    func closeDropDown()

}
class ExpandedCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblExpandedOptions: UITableView!
    var dataSourceArray:[String] = Array()
    var delegate: ExpandedCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tblExpandedOptions.register(UINib(nibName: "CustomExpandedCell", bundle: nil), forCellReuseIdentifier: "CellIdentifier")
        tblExpandedOptions.delegate = self
        tblExpandedOptions.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier") as! CustomExpandedCell
        cell.lblTitle?.text = dataSourceArray[indexPath.row]
        cell.lblTitle?.font = UIFont.boldSystemFont(ofSize: 14.0)
        cell.layoutLC.constant = 15
        cell.separatorInset.left = 15
        if indexPath.row != 0 {
            cell.layoutLC.constant = 40
            cell.lblTitle?.font = UIFont.systemFont(ofSize: 12.0)
            cell.separatorInset.left = 40
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            //we tap on same row who is expanded right now close it
            if delegate != nil {
                delegate.closeDropDown()
            }

        } else {
            //we tap on drop down selection, will pass the value and close dropdown in main class
            if delegate != nil {
                delegate.valueSelected(value: dataSourceArray[indexPath.row] as AnyObject)
            }
        }
        
    }

    
}
