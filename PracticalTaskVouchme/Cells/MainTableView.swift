//
//  MainTableView.swift
//  PracticalTaskVouchme
//
//  Created by Kavita Malagavi on Dec-10-2020.
//

import UIKit

protocol ExpandableTableDelegate {
    func valueSelected(value: AnyObject)
}

class MainTableView: UIViewController, ExpandedCellDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var dataSourceForPlainTable: DataModel?
    var indexToExpand = -1
    
    var delegate: ExpandableTableDelegate!
    var subCategories: [Subcategories]?
    var categoryName: String?
    var totalCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subCategories = dataSourceForPlainTable?.subCategories
        categoryName = dataSourceForPlainTable?.categoryName
        totalCount = dataSourceForPlainTable?.totalItems
        mainTableView.register(UINib(nibName: "ExpandedTableViewCell", bundle: nil), forCellReuseIdentifier: "ExpandedTableViewCell")
        mainTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
    }

    func valueSelected(value: AnyObject) {
        if delegate != nil {
            self.delegate.valueSelected(value: value)
        }
        closeDropDown()
    }
    
    func closeDropDown() {
        let indexpath = IndexPath(row: indexToExpand, section: 0)
        indexToExpand  = -1
        mainTableView.reloadRows(at: [indexpath], with: .fade)
    }

}

extension MainTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategories!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexToExpand == indexPath.row {
            let cellExpanded = tableView.dequeueReusableCell(withIdentifier: "ExpandedTableViewCell") as! ExpandedTableViewCell
            cellExpanded.delegate = self
            cellExpanded.dataSourceArray = subCategories![indexPath.row].products!
            cellExpanded.subcategoryName = subCategories![indexPath.row].subCategoryName
            cellExpanded.expandedTableview.reloadData()
            return cellExpanded
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
        cell.productDescriprion.text = "smith and jones pastas and others"
        cell.productSubcategory.text = subCategories![indexPath.row].subCategoryName
        cell.itemCount.text = "\(subCategories![indexPath.row].totalItems!) Items"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexToExpand == indexPath.row {
            indexToExpand  = -1
        } else {
            if indexToExpand != -1 {
                let indexpath = IndexPath(row: indexToExpand, section: 0)
                indexToExpand = indexPath.row
                mainTableView.reloadRows(at: [indexpath], with: .fade)
            }
            indexToExpand = indexPath.row

        }
        mainTableView.reloadRows(at: [indexPath], with: .fade)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexToExpand == indexPath.row {
            return CGFloat(150.0 * CGFloat(subCategories!.count - 1))
        } else {
            return 80
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("SectionHeader", owner: self, options: nil)?.last as? SectionHeader
        let headerTitle = "\(categoryName ?? "")"
        let itemCount = totalCount ?? 0
        header?.configure(text: headerTitle, count: itemCount)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

}
