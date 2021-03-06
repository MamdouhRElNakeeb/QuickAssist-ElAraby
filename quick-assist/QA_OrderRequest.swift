//
//  QA_OrderRequest.swift
//  quick-assist
//
//  Created by Mamdouh El Nakeeb on 10/4/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import UIKit
import Alamofire
import DropDown

class QA_OrderRequest: UIViewController {

    @IBOutlet weak var newProductBtn: UIButton!
    
    var requestProductLbl = UILabel()
    var addMoreBtn = UIButton()
    var totalPriceValueLbl = UILabel()
    var requestNowBtn = UIButton()
    var nameTF = UITextField()
    var phoneTF = UITextField()
    var cityBtn = UIButton()
    var cityDD = DropDown()
    var addressTF = UITextField()
    var userDataSubmitBtn = UIButton()
    
    var spinner = UIActivityIndicatorView()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var ordersTV = UITableView()
    var products = Array <Product>()
    var quanity = Array <Int>()
    
    let submitOrderUrl = "http://www.elarabyfamily.com:8080/api/CreateSalesOrder"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        quanity = [Int] (repeating: 1, count: products.count)
        
        initViews()
        calcPrice()
    }
    
    func initViews () {
        
        // Request Product Label
        requestProductLbl.frame = CGRect(x: 16, y: newProductBtn.frame.maxY + 10, width: self.view.frame.width / 2, height: 20)
        requestProductLbl.text = "Request Product"
        requestProductLbl.font = UIFont(name: requestProductLbl.font.fontName, size: 13)
        requestProductLbl.textColor = UIColor.gray
        
        // Add More Button
        addMoreBtn.frame = CGRect(x: self.view.frame.width / 2, y: requestProductLbl.frame.minY, width: self.view.frame.width / 2 - 32, height: 21)
        addMoreBtn.setTitle("Add More", for: .normal)
        addMoreBtn.titleLabel?.font = requestProductLbl.font
        addMoreBtn.setTitleColor(UIColor.gray, for: .normal)
        addMoreBtn.contentHorizontalAlignment = .right
        addMoreBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        initOrdersTV()
        
        // Total Price View
        let totalPriceView = UIView(frame: CGRect(x: ordersTV.frame.minX, y: ordersTV.frame.maxY + 10, width: self.view.frame.width - 32, height: 30))
        totalPriceView.backgroundColor = UIColor.white
        
        totalPriceValueLbl.frame = CGRect(x: totalPriceView.frame.width / 2, y: 0, width: totalPriceView.frame.width / 2, height: totalPriceView.frame.height)
        totalPriceValueLbl.textColor = UIColor.blue()
        totalPriceValueLbl.font = UIFont(name: totalPriceValueLbl.font.fontName, size: 13)
        
        let totalPriceLbl = UILabel(frame: CGRect(x: 0, y: 0, width: totalPriceView.frame.width / 2 - 10, height: totalPriceView.frame.height))
        
        totalPriceLbl.text = "Total Price:  "
        totalPriceLbl.font = UIFont(name: totalPriceLbl.font.fontName, size: 13)
        totalPriceLbl.textAlignment = .right
        
        totalPriceView.addSubview(totalPriceValueLbl)
        totalPriceView.addSubview(totalPriceLbl)
        
        // Request Now Button
        requestNowBtn.frame = CGRect(x: totalPriceView.frame.minX, y: totalPriceView.frame.maxY + 10, width: totalPriceView.frame.width, height: 0)
        requestNowBtn.setTitle("Request Now", for: .normal)
        requestNowBtn.setTitleColor(UIColor.white, for: .normal)
        requestNowBtn.backgroundColor = UIColor.blue()
        requestNowBtn.titleLabel?.font = UIFont(name: (requestNowBtn.titleLabel?.font.fontName)!, size: 14)
        requestNowBtn.addTarget(self, action: #selector(requestNowOnClick), for: .touchUpInside)
        requestNowBtn.isHidden = true
        
        // User Data View
        let userDataV = UIView(frame: CGRect(x: requestNowBtn.frame.minX, y: requestNowBtn.frame.maxY, width: requestNowBtn.frame.width, height: 186))
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
        userDataSubmitBtn.addTarget(self, action: #selector(submitOrderBtnOnClick), for: .touchUpInside)
        
        // Add Views to Main View
        self.view.addSubview(requestProductLbl)
        self.view.addSubview(addMoreBtn)
        self.view.addSubview(totalPriceView)
        self.view.addSubview(requestNowBtn)
        self.view.addSubview(userDataV)
        self.view.addSubview(userDataSubmitBtn)
        
        
        initSpinner()
        
    }
    
    func showCityDropDown (){
        cityDD.show()
    }
    
    func initOrdersTV(){
        
        var ordersTVH = 0
        if products.count >= 3 {
            ordersTVH = 120
        }
        else {
            ordersTVH = products.count * 40
        }
        ordersTV = UITableView(frame: CGRect(x: requestProductLbl.frame.minX, y: requestProductLbl.frame.maxY + 10, width: self.view.frame.width, height: CGFloat(ordersTVH)))
        
        ordersTV.register(OrderTVCell.self, forCellReuseIdentifier: "orderCell")
        
        ordersTV.dataSource = self
        ordersTV.delegate = self
        ordersTV.separatorStyle = .none
        ordersTV.backgroundColor = UIColor.clear
        
        self.view.addSubview(ordersTV)
        
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
    
    func calcPrice() {
        var totalPrice = 0
        
        for i in 0..<products.count {
            totalPrice += products[i].price * quanity[i]
        }
        
        totalPriceValueLbl.text = "\(totalPrice) EGP"
    }
    
    func submitOrder (userInfo: String, products: String){
        
        displaySpinner()
        let parameters: Parameters = [
        "userInfo": userInfo,
        "products": products,
        "session_token": "79998c2a-7fa7-4776-a6ad-6620ebacc9bb"]
        
        print("params \(parameters)")
        
        Alamofire.request(submitOrderUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON{
                
                response in
                
                self.dismissSpinner()
                
                print(response)
                
                if let resault = response.result.value {
                    
                    print(resault)
                }
                
                
        }
    }
    
    func requestNowOnClick (){
        
        let name = UserDefaults.standard.string(forKey: "name")
        let mobile = UserDefaults.standard.string(forKey: "mobile")
        let city = UserDefaults.standard.string(forKey: "city")
        let address = UserDefaults.standard.string(forKey: "address")

        let userInfo = userDataToJson(name: name!, mobile: mobile!, city: city!, address: address!)
        let products = orderToJson()
        var userInfoStr = ""
        var productsStr = ""
        
        if let data = try? JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted) {
            userInfoStr = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! //String(bytes: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            print(userInfoStr)
        }
        
        if let data = try? JSONSerialization.data(withJSONObject: products, options: .prettyPrinted) {
            productsStr = String(bytes: data, encoding: .utf8)!
            print(productsStr)
        }
        
        submitOrder(userInfo: userInfoStr, products: productsStr)
        
        
    }
    
    func submitOrderBtnOnClick (){
        
        let userInfo = userDataToJson(name: nameTF.text!, mobile: phoneTF.text!, city: (cityBtn.titleLabel?.text!)!, address: addressTF.text!)
        let products = orderToJson()
        var userInfoStr = ""
        var productsStr = ""
        
        var submitDict: [String: Any] = [:]
        
        submitDict["userInfo"] = userInfo
        submitDict["products"] = orderToJson()
        
        if let data = try? JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted) {
            userInfoStr = String(bytes: data, encoding: .utf8)!
            print(userInfoStr)
        }
        
        if let data = try? JSONSerialization.data(withJSONObject: products, options: .prettyPrinted) {
            productsStr = String(bytes: data, encoding: .utf8)!
            print(productsStr)
        }
        
        submitOrder(userInfo: userInfoStr, products: productsStr)
        
        
    }
    
    func userDataToJson(name: String, mobile: String, city: String, address: String) -> NSObject {
        var dict : [String: AnyObject] = [:]
        dict["name"] = (name) as AnyObject
        dict["mobile"] = (mobile) as AnyObject
        dict["city"] = (city) as AnyObject
        dict["address"] = (address) as AnyObject
        
        return dict as NSObject
    }
    
    func orderToJson() -> NSObject {
        var dict = [[String: Any]]()
        
        for i in 0..<products.count {
            var productDict: [String: AnyObject] = [:]
            productDict["sku"] = products[i].sku as AnyObject
            productDict["qty"] = quanity[i] as AnyObject
            productDict["price"] = products[i].price as AnyObject
            
            let dic: [String: Any] = ["sku": products[i].sku,
                                      "qty": quanity[i],
                                      "price": products[i].price]
            
            
            dict.append(dic)
        }
        
        return dict as NSObject
    }
    
    func goBack() {
        _ = navigationController?.popViewController(animated: true)
    }
}

extension QA_OrderRequest: UITableViewDelegate, UITableViewDataSource, OrderCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        
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
            
            self.calcPrice()
            
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
