//
//  Urls.swift
//  quick-assist
//
//  Created by Mamdouh El Nakeeb on 10/13/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import Foundation

class Urls {
    
    static var base = "https://www.elarabygroup.com/en/api/index/"
    static var brands = base + "brands"
    static var categories = base + "categories"
    static var products = base + "products"
    
    static var familyAPI = "http://www.elarabyfamily.com:8080/api/"
    
    static var orderRequest = "CreateSalesOrder"
    static var orderFollowUp = familyAPI + "SalesOrderFollowup"
    static var orderRemind = familyAPI + "SalesRemind"
    
    
}
