//
//  QA_ProductsHomeVC.swift
//  quick-assist
//
//  Created by HANHON on 10/8/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import UIKit

class QA_ProductsHomeVC: UIViewController {

    @IBOutlet weak var newProductBtn: UIButton!
    @IBOutlet weak var productsV: UIView!
    @IBOutlet weak var productsFollowUpV: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        newProductBtn.frame = CGRect(x: 20, y: self.navigationController!.navigationBar.frame.height + 10, width: self.view.frame.width / 2 - 20, height: 40)
        
        productsV.frame = CGRect(x: 0, y: newProductBtn.frame.maxY + 50, width: self.view.frame.width, height: self.view.frame.height - newProductBtn.frame.maxY)
        
        productsFollowUpV.frame = CGRect(x: 0, y: newProductBtn.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - newProductBtn.frame.maxY)
        productsFollowUpV.isHidden = true
    }

}
