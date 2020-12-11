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
