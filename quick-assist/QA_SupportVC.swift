//
//  QA_SupportVC.swift
//  quick-assist
//
//  Created by Mamdouh El Nakeeb on 9/17/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import UIKit
import DropDown

class QA_SupportVC: UIViewController {

    var nameTF = UITextField()
    var phoneTF = UITextField()
    var cityBtn = UIButton()
    var cityDD = DropDown()
    var addressTF = UITextField()
    var detailsTV = UITextView()
    var userDataSubmitBtn = UIButton()
    
    var spinner = UIActivityIndicatorView()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

    
    let submitRequestUrl = "https://www.elarabyfamily.com:8080/api/CreateSalesOrder11"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    func initViews () {
        
        // User Data View
        let userDataV = UIView(frame: CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width, height: 186))
        userDataV.backgroundColor = UIColor.white
        
        nameTF.frame = CGRect(x: 10, y: 20, width: userDataV.frame.width - 20, height: 30)
        nameTF.placeholder = "Name"
        nameTF.font = UIFont(name: (nameTF.font?.fontName)!, size: 13)
        nameTF.borderStyle = .roundedRect
        nameTF.clearButtonMode = .whileEditing
        
        phoneTF.frame = CGRect(x: 10, y: nameTF.frame.maxY + 8, width: userDataV.frame.width - 20, height: 30)
        phoneTF.font = nameTF.font
        phoneTF.placeholder = "Tele"
        phoneTF.borderStyle = .roundedRect
        phoneTF.clearButtonMode = .whileEditing
        phoneTF.keyboardType = .phonePad
        
        cityBtn.frame = CGRect(x: 10, y: phoneTF.frame.maxY + 8, width: userDataV.frame.width - 20, height: 30)
        cityBtn.setTitle("  City", for: .normal)
        cityBtn.titleLabel?.font = nameTF.font
        cityBtn.setTitleColor(UIColor.lightGray, for: .normal)
        cityBtn.contentHorizontalAlignment = .left
        cityBtn.backgroundColor = UIColor.clear
        cityBtn.addBorder(view: cityBtn, stroke: UIColor.greyMidColor(), fill: UIColor.clear, radius: 5, width: 2)
        cityBtn.addTarget(self, action: #selector(showCityDropDown), for: .touchUpInside)
        //cityBtn.isEnabled = false
        
        cityDD.frame = cityBtn.frame
        cityDD.anchorView = cityBtn
        cityDD.dataSource = ["Cairo", "Alexandria", "Giza", "Suez", "Portsaid"]
        cityDD.direction = .any
        cityDD.dismissMode = .onTap
        
        cityDD.selectionAction = { [unowned self] (index, item) in
            self.cityBtn.setTitle("  " + item, for: .normal)
            self.cityBtn.setTitleColor(UIColor.black, for: .normal)
        }
        
        
        addressTF.frame = CGRect(x: 10, y: cityBtn.frame.maxY + 8, width: userDataV.frame.width - 20, height: 30)
        addressTF.placeholder = "Address"
        addressTF.font = nameTF.font
        addressTF.borderStyle = .roundedRect
        addressTF.clearButtonMode = .whileEditing
        
        userDataV.addSubview(nameTF)
        userDataV.addSubview(phoneTF)
        userDataV.addSubview(cityBtn)
        userDataV.addSubview(cityDD)
        userDataV.addSubview(addressTF)
        
        
        userDataSubmitBtn.frame = CGRect(x: userDataV.frame.minX, y: userDataV.frame.maxY + 10, width: userDataV.frame.width, height: 30)
        userDataSubmitBtn.setTitle("Submit", for: .normal)
        userDataSubmitBtn.setTitleColor(UIColor.white, for: .normal)
        userDataSubmitBtn.titleLabel?.font = UIFont(name: (userDataSubmitBtn.titleLabel?.font.fontName)!, size: 14)
        userDataSubmitBtn.backgroundColor = UIColor.blue()
        userDataSubmitBtn.addTarget(self, action: #selector(submitBtnOnClick), for: .touchUpInside)
        
        // Add Views to Main View
        self.view.addSubview(userDataV)
        self.view.addSubview(userDataSubmitBtn)
        
        
        initSpinner()
        
    }
    
    func showCityDropDown (){
        cityDD.show()
    }
    
    func submitBtnOnClick (){
        
    }
    
    func initSpinner(){
        spinner.activityIndicatorViewStyle = .gray
        spinner.center = self.view.center
        
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
        spinner.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        
        let strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = "Loading"
        strLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        effectView.addSubview(spinner)
        effectView.addSubview(strLabel)
        
    }
    
    func dismissSpinner(){
        spinner.stopAnimating()
        effectView.removeFromSuperview()
    }
    
    func displaySpinner(){
        spinner.startAnimating()
        self.view.addSubview(effectView)
    }
    
}
