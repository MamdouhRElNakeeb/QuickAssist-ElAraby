//
//  ViewController.swift
//  quick-assist
//
//  Created by Mamdouh El Nakeeb on 9/5/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import UIKit

class QA_HomeVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var productsV: UIView!
    @IBOutlet weak var supportV: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let productsTap = UITapGestureRecognizer(target: self, action: #selector(openProducts))
        productsTap.delegate = self
        productsV.addGestureRecognizer(productsTap)
        
        let supportTap = UITapGestureRecognizer(target: self, action: #selector(openSupport))
        supportTap.delegate = self
        supportV.addGestureRecognizer(supportTap)

        
    }

    func openProducts(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "productsHome") as! QA_ProductsHomeVC
        self.navigationController?.pushViewController(newViewController, animated: true)

    }
 
    func openSupport(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "supportHome") as! QA_SupportHomeVC
        self.navigationController?.pushViewController(newViewController, animated: true)

    }

}

