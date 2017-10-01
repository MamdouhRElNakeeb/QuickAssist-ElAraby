//
//  AppDelegate.swift
//  quick-assist
//
//  Created by Mamdouh El Nakeeb on 9/5/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    let realm = try! Realm()

    let brandsUrl = "https://www.elarabygroup.com/portal_test/en/api/index/brands"
    let categoriesUrl = "https://www.elarabygroup.com/portal_test/en/api/index/categories"
    let productsUrl = "https://www.elarabygroup.com/portal_test/en/api/index/products"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)

        
        return true
    }

    // Support for background fetch
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        _ = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(syncDB), userInfo: nil, repeats: true)

    }
    
    func syncDB(){
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        print("hours = \(hour):\(minutes):\(seconds)")
        
        if hour == 3 {
            
            loadBrands()
            loadCategories()
            loadProducts()
        }

    }
    
    func loadBrands(){
        
        
        Alamofire.request(brandsUrl)
            .responseJSON{
                
                response in
                
                print(response)
                
                if let result = response.result.value{
                    
                    let brandJSONArr = result as! NSArray
                    
                    try! self.realm.write {
                        self.realm.delete(self.realm.objects(Brand.self))
                    }
                    
                    for brandJSONObj in brandJSONArr{
                        
                        let brand = Brand()
                        brand.id = Int((brandJSONObj as AnyObject).value(forKey: "id") as! String)!
                        brand.name = (brandJSONObj as AnyObject).value(forKey: "name") as! String
                        brand.image = (brandJSONObj as AnyObject).value(forKey: "image") as! String
                        
                        
                        try! self.realm.write {
                            
                            self.realm.add(brand)
                            
                            print(brand.name)
                        }
                        
                    }
                    
                }
                
        }
        
    }

    
    func loadCategories(){
        
        
        Alamofire.request(categoriesUrl)
            .responseJSON{
                
                response in
                
                print(response)
                
                if let result = response.result.value{
                    
                    let categoryJSONArr = result as! NSArray
                    
                    try! self.realm.write {
                        self.realm.delete(self.realm.objects(Category.self))
                    }
                    
                    for categoryJSONObj in categoryJSONArr{
                        
                        let category = Category()
                        category.id = Int((categoryJSONObj as AnyObject).value(forKey: "id") as! String)!
                        category.name = (categoryJSONObj as AnyObject).value(forKey: "name") as! String
                        category.image = (categoryJSONObj as AnyObject).value(forKey: "image") as! String
                        
                        let brandsJSONArr = (categoryJSONObj as AnyObject).value(forKey: "brands") as! NSArray
                        
                        var brands = Array<String>()
                        for brandObj in brandsJSONArr{
                            
                            brands.append(brandObj as! String)
                            
                        }
                        
                        category.brands = brands.joined(separator: ",")
                        
                        
                        try! self.realm.write {
                            
                            self.realm.add(category)
                            
                            print(category.name)
                        }
                        
                    }
                    
                }
                
        }
        
    }

    
    func loadProducts(){
        
        
        Alamofire.request(productsUrl)
            .responseJSON{
                
                response in
                
                print(response)
                
                if let result = response.result.value{
                    
                    let productsJSONArr = result as! NSArray
                    
                    try! self.realm.write {
                        self.realm.delete(self.realm.objects(Product.self))
                    }
                    
                    for productJSONObj in productsJSONArr{
                        
                        let product = Product()
                        product.id = Int((productJSONObj as AnyObject).value(forKey: "id") as! String)!
                        product.name = (productJSONObj as AnyObject).value(forKey: "name") as! String
                        product.sku = (productJSONObj as AnyObject).value(forKey: "sku") as! String
                        
                        product.brand = Int((productJSONObj as AnyObject).value(forKey: "brand") as! String)!
                        product.image = (productJSONObj as AnyObject).value(forKey: "image") as! String
                        product.url = (productJSONObj as AnyObject).value(forKey: "url") as! String
                        
                        let priceStr = (productJSONObj as AnyObject).value(forKey: "price") as! String
                        
                        let index = priceStr.index(priceStr.startIndex, offsetBy: priceStr.indexOf(string: "."))
                        
                        product.price = Int(priceStr.substring(to: index))!
                        
                        product.desc = (productJSONObj as AnyObject).value(forKey: "description") as! String
                        
                        let categoriesJSONArr = (productJSONObj as AnyObject).value(forKey: "category") as! NSArray
                        
                        var categories = Array<String>()
                        for categoryObj in categoriesJSONArr{
                            
                            categories.append(categoryObj as! String)
                            
                        }
                        
                        product.category = categories.joined(separator: ",")
                        
                        
                        try! self.realm.write {
                            
                            self.realm.add(product)
                            
                            print(product.name)
                        }
                        
                    }
                    
                }
                
        }
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

