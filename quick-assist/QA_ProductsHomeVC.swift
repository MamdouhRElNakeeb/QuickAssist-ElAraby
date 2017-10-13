//
//  QA_ProductsHomeVC.swift
//  quick-assist
//
//  Created by HANHON on 10/8/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import UIKit

class QA_ProductsHomeVC: UIViewController {
    
    // TODO
    /*
     * Protocol of ProductsVC
     * When products done clicked -> container -> OrderRequest
     * Make Order Request a child of Container
     **/

    @IBOutlet weak var newProductBtn: UIButton!
    @IBOutlet weak var followUpBtn: UIButton!

    
    var container: ContainerViewController!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        newProductBtn.frame = CGRect(x: 10, y: self.navigationController!.navigationBar.bounds.maxY + 30, width: self.view.frame.width / 2 - 15, height: 30)
        
        followUpBtn.frame = CGRect(x: newProductBtn.frame.maxX + 10, y: newProductBtn.frame.minY, width: newProductBtn.frame.width, height: newProductBtn.frame.height)
    }

    
    @IBAction func newProductBtnOnClick(_ sender: Any) {
        
        container!.segueIdentifierReceivedFromParent("productsSegue")
        
        newProductBtn.setTitleColor(UIColor.white, for: .normal)
        newProductBtn.backgroundColor = UIColor.blue()
        
        followUpBtn.setTitleColor(UIColor.black, for: .normal)
        followUpBtn.backgroundColor = UIColor.white
        

    }
    
    @IBAction func followUpBtnOnClick(_ sender: Any) {
        
        container!.segueIdentifierReceivedFromParent("productsFollowSegue")

        newProductBtn.setTitleColor(UIColor.black, for: .normal)
        newProductBtn.backgroundColor = UIColor.white
        
        followUpBtn.setTitleColor(UIColor.white, for: .normal)
        followUpBtn.backgroundColor = UIColor.blue()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            
            container = segue.destination as! ContainerViewController
            
            
        }
    }
    
}
