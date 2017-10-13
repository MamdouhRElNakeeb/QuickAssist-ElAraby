//
//  QA_ProductsFollowUpVC.swift
//  quick-assist
//
//  Created by HANHON on 10/8/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import UIKit
import Alamofire

class QA_ProductsFollowUpVC: UIViewController {

    var followUpTV = UITableView()
    
    var followUpArr = Array<FollowUp>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initTV()
    }

    func loadFollowUp(){
    
        let params = [
            "session_token": "79998c2a-7fa7-4776-a6ad-6620ebacc9bb",
            "time_offset": "120",
            "page_index": "0",
            "page_size": "10"
        ]
        
        Alamofire.request(Urls.orderFollowUp, method: .post, parameters: params).responseJSON{
            
            response in
            
            if let result = response.result.value {
              
                let json = result as! NSObject
                
                let dataJSONArr = json.value(forKey: "Data") as! NSArray
                
                for dataJSONObj in dataJSONArr{
                    
                    followUpArr.append(FollowUp.init(id: (dataJSONObj as AnyObject).value(forKey: "id"),
                                                     userName: (dataJSONObj as AnyObject).value(forKey: "id"),
                                                     date: (dataJSONObj as AnyObject).value(forKey: "id"),
                                                     status: (dataJSONObj as AnyObject).value(forKey: "id"),
                                                     price: (dataJSONObj as AnyObject).value(forKey: "id"),
                                                     productsSKU: (dataJSONObj as AnyObject).value(forKey: "id")))
                }
                
                
                followUpTV.reloadData()
                
            
            }
        }
        
    }
    
    func initTV(){
        followUpTV = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height), style: UITableViewStyle.plain)
        followUpTV.register(FollowUpCell.self, forCellReuseIdentifier: "productFollowUpCell")
        followUpTV.dataSource = self
        followUpTV.delegate = self
        
        self.view.addSubview(followUpTV)
    }
}

extension QA_ProductsFollowUpVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followUpArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productFollowUpCell", for: indexPath) as! FollowUpCell

        cell.nameLbl.text = followUpArr[indexPath.row].userName
        cell.priceValueLbl.text = "\(followUpArr[indexPath.row].price)"
        cell.productsLbl.text = followUpArr[indexPath.row].productsSKU
        cell.dateLbl.text = followUpArr[indexPath.row].date
        cell.statusLbl.text = followUpArr[indexPath.row].date
        
        return cell
    }
}
