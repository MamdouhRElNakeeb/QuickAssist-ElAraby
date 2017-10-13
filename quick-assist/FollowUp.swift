//
//  OrderFollowUp.swift
//  quick-assist
//
//  Created by Mamdouh El Nakeeb on 10/13/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import Foundation

class FollowUp {
    
    var id = 0
    var userName = ""
    var date = ""
    var status = ""
    var price = 0
    var productsSKU = ""
    
    init(id: Int, userName: String, date: String, status: String, price: Int, productsSKU: String) {
        
        self.id = id
        self.userName = userName
        self.date = date
        self.status = status
        self.price = price
        self.productsSKU = productsSKU
        
    }
    
}
