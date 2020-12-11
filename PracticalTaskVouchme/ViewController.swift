//
//  ViewController.swift
//  PracticalTaskVouchme
//
//  Created by Kavita Malagavi on Dec-9-2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cartItemCount: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var productViewModel = ProductViewModel()
    var dataSourceForPlainTable: DataModel?
    var delegate: UpdateCartCountDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.startAnimating()
//        updateCount()

        getProducts()
    }

    @objc func showSpinningWheel(_ notification: NSNotification) {
            print(notification.userInfo ?? "")
            if let dict = notification.userInfo as NSDictionary? {
                if let count = dict["count"] as? String {
                    cartItemCount.text = count
                }
            }
     }
    
    func updateCount() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSpinningWheel(_:)), name: NSNotification.Name(rawValue: "newDataToLoad"), object: nil)
    }
    
    func getProducts() {
        productViewModel.fetchproducts(successCallback: {
            DispatchQueue.main.async { [self] in
                loader.stopAnimating()
                dataSourceForPlainTable = self.productViewModel.productList?.dataArr?.first
                
                let expandableTable = MainTableView(nibName: "MainTableView", bundle: nil)
                expandableTable.dataSourceForPlainTable = dataSourceForPlainTable!
                expandableTable.view.frame = CGRect(x: 0, y: 210, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 274)
                self.view.addSubview(expandableTable.view)
                self.addChild(expandableTable)
                expandableTable.mainTableView.reloadData()
            }
        }, failureCallback: {
            self.loader.stopAnimating()
        })
    }
}

extension ViewController: UpdateCartCountDelegate {
    func updateCount(with count: Int) {        
        cartItemCount.text = "\(count)"
    }
}

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return productViewModel.productsCount(index: section)
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return productViewModel.getCategoryCount()
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let productCell = tableView.dequeueReusableCell(withIdentifier: "productCell",for: indexPath) as? ProductCell else { return UITableViewCell()}
//        productCell.productSubcategory.text = productViewModel.getSubcategoryForIndex(index: indexPath)
//        productCell.itemCount.text = "\(productViewModel.getTotalItemForIndex(index: indexPath)) Items"
//        return productCell
//    }
//
//    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = Bundle.main.loadNibNamed("SectionHeader", owner: self, options: nil)?.last as? SectionHeader
//        let headerTitle = "\(productViewModel.getCategoryNameForSection(index: section))"
//        let itemCount = productViewModel.getItemCountForSection(index: section)
//        header?.configure(text: headerTitle, count: itemCount)
//        return header
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
//
//}

