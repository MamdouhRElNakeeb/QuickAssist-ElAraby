//
//  QA_OrderRequest.swift
//  quick-assist
//
//  Created by Mamdouh El Nakeeb on 10/4/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import UIKit

class QA_OrderRequest: UIViewController {

    @IBOutlet weak var newProductBtn: UIButton!
    
    var ordersTV = UITableView()
    var products = Array <Product>()
    var quanity = Array <Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        quanity = [Int] (repeating: 1, count: products.count)
        
        initOrdersTV()
    }
    
    
    func initOrdersTV(){
        
        ordersTV = UITableView(frame: CGRect(x: 20, y: newProductBtn.frame.maxY + 30, width: self.view.frame.width - 40, height: CGFloat(products.count * 40)), style: UITableViewStyle.plain)
        ordersTV.register(OrderTVCell.self, forCellReuseIdentifier: "orderCell")
        ordersTV.dataSource = self
        ordersTV.delegate = self
        ordersTV.separatorStyle = .singleLine
        
        self.view.addSubview(ordersTV)
        
    }

    @IBAction func addMoreBtnOnClick(_ sender: Any) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    

    @IBAction func requestNowOnClick(_ sender: Any) {
        
    }
    
    @IBAction func submitDataOnClick(_ sender: Any) {
        
    }
}

extension QA_OrderRequest: UITableViewDelegate, UITableViewDataSource, OrderCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTVCell
        
        cell.productNameLbl.text = products[indexPath.row].name
        cell.priceValueLbl.text = "\(products[indexPath.row].price) EGP"
        
        cell.orderRemoveOnClick = self
        cell.tag = indexPath.row
        cell.quantityBtn.setTitle("\(quanity[indexPath.row])", for: .normal)
        
        cell.quantityDD.selectionAction = { [unowned self] (index, item) in
            
            cell.quantityBtn.setTitle(item, for: .normal)
            self.quanity[indexPath.row] = Int(item)!
            
        }
        
        return cell
    }
    
    func orderRemoveOnClick(tag: Int) {
        products.remove(at: tag)
        ordersTV.reloadData()
        
        if products.isEmpty {
            _ = navigationController?.popViewController(animated: true)
        }
    }
}
