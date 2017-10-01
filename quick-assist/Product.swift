//
//  Product.swift
//  quick-assist
//
//  Created by Mamdouh El Nakeeb on 9/18/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import RealmSwift

class Product: Object {
    
    dynamic var id = 0
    dynamic var name = ""
    dynamic var sku = ""
    dynamic var price = 0
    dynamic var image = ""
    dynamic var url = ""
    dynamic var desc = ""
    dynamic var brand = 0
    dynamic var category = ""
   
}
