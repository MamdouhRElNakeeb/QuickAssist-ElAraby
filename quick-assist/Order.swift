//
//  Order.swift
//  quick-assist
//
//  Created by Mamdouh El Nakeeb on 10/4/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import Foundation

class Order {
    
    var id = 0
    var products = Array <Product>()
    var quantity = Array <Int>()
    var price = 0
    var dateInMillis = 0
    var status = ""
    
    init(id: Int, products: Array <Product>, quantity: Array<Int>, price: Int, dateInMillis: Int, status: String) {
        
        self.id = id
        self.products = products
        self.quantity = quantity
        self.price = price
        self.dateInMillis = dateInMillis
        self.status = status
        
    }
    
    init (){
        
    }
}
