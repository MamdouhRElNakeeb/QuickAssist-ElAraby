//
//  QA_ProductsVC.swift
//  quick-assist
//
//  Created by Mamdouh El Nakeeb on 9/17/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class QA_ProductsVC: UIViewController {

    @IBOutlet weak var brandsV: UIView!
    @IBOutlet weak var categoryV: UIView!
    @IBOutlet weak var productsV: UIView!
    @IBOutlet weak var brandsCV: UICollectionView!
    @IBOutlet weak var categoriesCV: UICollectionView!
    @IBOutlet weak var productsCV: UICollectionView!
    @IBOutlet weak var brandsDoneBtn: UIButton!
    @IBOutlet weak var categoriesDoneBtn: UIButton!
    @IBOutlet weak var productsDoneBtn: UIButton!
    @IBOutlet weak var newProductBtn: UIButton!
    
    var spinner = UIActivityIndicatorView()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    let brandsUrl = "https://www.elarabygroup.com/portal_test/en/api/index/brands"
    let categoriesUrl = "https://www.elarabygroup.com/portal_test/en/api/index/categories"
    let productsUrl = "https://www.elarabygroup.com/portal_test/en/api/index/products"
    
    var brandsArr = Array<Brand>()
    var categoriesArr = Array<Category>()
    var productsArr = Array<Product>()
    
    
    var categoriesFilteredArr = Array<Category>()
    
    var brandsSelArr = Array<Int>()
    var categoriesSelArr = Array<Int>()
    var productsSelArr = Array<Int>()
    
    var brandsElapsed = true
    var categoriesElapsed = false
    var productsElapsed = false
    
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let brandsRealm = realm.objects(Brand.self)
        let categoriesRealm = realm.objects(Category.self)
        let productsRealm = realm.objects(Product.self)
        
        brandsArr = Array(brandsRealm)
        categoriesArr = Array(categoriesRealm)
        productsArr = Array(productsRealm)
        
        
        //initSpinner()
        initBrandsCV()
        initCatagoriesCV()
        initProductsCV()
        loadBrands()
    }

    func initBrandsCV(){
        let itemSize = (self.view.frame.width - 30) / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSize(width: itemSize, height: 40)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        brandsCV.setCollectionViewLayout(flowLayout, animated: true)
        brandsCV.register(BrandCVCell.self, forCellWithReuseIdentifier: "brandCell")
        
        
        brandsV.frame = CGRect(x: 10
            , y: newProductBtn.frame.maxY + 10, width: self.view.frame.width - 20, height: view.frame.maxY - newProductBtn.frame.maxY - 20)
        
        brandsCV.frame = CGRect(x: 10
            , y: 25, width: self.view.frame.width - 30, height: CGFloat(ceil(Double(brandsArr.count) / 2)) * 40 + 25)
        
        brandsCV.layer.masksToBounds = true

    }
    
    func initCatagoriesCV(){
        let itemSize = self.view.frame.width - 25
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSize(width: itemSize, height: 40)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        categoriesCV.setCollectionViewLayout(flowLayout, animated: true)
        categoriesCV.register(CategoryCVCell.self, forCellWithReuseIdentifier: "categoryCell")
        
        categoryV.frame = CGRect(x: 10
            , y: brandsV.frame.maxY + 10, width: self.view.frame.width - 20, height: 25)
        
        categoriesCV.frame = CGRect(x: 10
            , y: categoryV.frame.minY + 25, width: self.view.frame.width - 30, height: 0)
        
        categoriesCV.layer.masksToBounds = true
        
    }
    
    func initProductsCV(){
        let itemSize = self.view.frame.width - 25
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSize(width: itemSize, height: 77)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        productsCV.setCollectionViewLayout(flowLayout, animated: true)
        productsCV.register(ProductCVCell.self, forCellWithReuseIdentifier: "productCell")
        
        productsV.frame = CGRect(x: 10, y: categoryV.frame.maxY + 10, width: self.view.frame.width - 20, height: 25)
        
        productsCV.frame = CGRect(x: 10, y: productsV.frame.minY + 25, width: self.view.frame.width - 30, height: 0)
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
    
    func refreshViews(){
        
         brandsV.frame = CGRect(x: brandsV.frame.minX, y: brandsV.frame.minY, width: brandsV.frame.width, height: CGFloat(brandsArr.count * 20))
        
         categoryV.frame = CGRect(x: brandsV.frame.minX, y: brandsV.frame.minY, width: brandsV.frame.width, height: CGFloat(brandsArr.count * 20))
    }
    
    func loadBrands(){
        
        
        if brandsArr.count == 0 {
            Alamofire.request(brandsUrl)
                .responseJSON{
                    
                    response in
                    
                    self.dismissSpinner()
                    
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
                            
                            self.brandsArr.append(brand)
                            
                            
                            try! self.realm.write {
                                
                                self.realm.add(brand)
                                
                                print(brand.name)
                            }
                            
                        }
                        
                    }
                    
                    self.brandsCV.reloadData()
            }
            
        }

    }
    
    @IBAction func brandSelectDoneOnClick(_ sender: Any) {
        
        if brandsSelArr.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Please select one brand at least", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            return
        }
        
        if brandsElapsed {
            /*
            var filterStr = (brandsSelArr.map{String($0)}).joined(separator: "' OR '")
            let index = filterStr.index(filterStr.startIndex, offsetBy: filterStr.characters.count - 1)
            filterStr = filterStr.substring(to: index)
            */
    
            var filterStr = ""
            for i in (0..<brandsSelArr.count){
                filterStr += "brands CONTAINS '" + "\(brandsSelArr[i])" + "'"
                if (i != brandsSelArr.count - 1){
                    filterStr += " OR "
                }
            }
            
            let categoriesRealm = realm.objects(Category.self).filter(filterStr)
            print(filterStr)
            
            print(categoriesRealm)
            categoriesFilteredArr = Array(categoriesRealm)
            
            brandsElapsed = false
            categoriesElapsed = true
            productsElapsed = false
            
            brandsDoneBtn.setTitle("Edit", for: .normal)
            categoriesDoneBtn.setTitle("Done", for: .normal)
            productsDoneBtn.setTitle("Edit", for: .normal)
            
            brandsV.frame = CGRect(x: 10, y: brandsV.frame.minY, width: self.view.frame.width - 20, height: CGFloat(ceil(Double(brandsSelArr.count) / 2)) * 40 + 25)
            
            brandsCV.frame = CGRect(x: 10, y: 25, width: self.view.frame.width - 30, height: CGFloat(ceil(Double(brandsSelArr.count) / 2)) * 40)
            
            categoryV.frame = CGRect(x: 10, y: brandsV.frame.maxY + 10, width: self.view.frame.width - 20, height: self.view.frame.maxY - brandsV.frame.maxY - 20)
            
            categoriesCV.frame = CGRect(x: 10, y: 25, width: self.view.frame.width - 30, height: categoryV.frame.height - 35)
            
            productsV.frame = CGRect(x: productsV.frame.minX, y: categoryV.frame.maxY + 10, width: productsV.frame.width, height: 25)
            
        }
        else {
            
            brandsElapsed = true
            categoriesElapsed = false
            productsElapsed = false
            brandsDoneBtn.setTitle("Done", for: .normal)
            categoriesDoneBtn.setTitle("Edit", for: .normal)
            productsDoneBtn.setTitle("Edit", for: .normal)
            
            brandsV.frame = CGRect(x: brandsV.frame.minX, y: brandsV.frame.minY, width: brandsV.frame.width, height: self.view.frame.maxY - brandsV.frame.minY - 10)
            
            brandsCV.frame = CGRect(x: 10, y: 25, width: brandsV.frame.width - 10, height: self.view.frame.maxY - brandsV.frame.minY - 35)
            
            categoryV.frame = CGRect(x: 10, y: brandsV.frame.maxY + 10, width: categoryV.frame.width, height: 25)
            categoriesCV.frame = CGRect(x: 10, y: 25, width: categoryV.frame.width - 10, height: 0)
            
            productsV.frame = CGRect(x: 10, y: categoryV.frame.maxY + 10, width: productsV.frame.width, height: 25)
        }
        
        
        
        self.brandsCV.reloadData()
        self.categoriesCV.reloadData()
        
    }
    
    @IBAction func categorySelectOnClick(_ sender: Any) {
        
        if categoriesSelArr.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Please select one category at least", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        if categoriesElapsed {
            
            brandsElapsed = false
            categoriesElapsed = false
            productsElapsed = true
            
            brandsDoneBtn.setTitle("Edit", for: .normal)
            categoriesDoneBtn.setTitle("Edit", for: .normal)
            productsDoneBtn.setTitle("Done", for: .normal)
            
            categoryV.frame = CGRect(x: 10, y: brandsV.frame.maxY + 10, width: categoryV.frame.width, height: 25)
            categoriesCV.frame = CGRect(x: 20, y: 25, width: categoryV.frame.width, height: 0)
            
            productsV.frame = CGRect(x: productsV.frame.minX, y: categoryV.frame.maxY + 10, width: productsV.frame.width, height: 25)
            
        }
        else {
            
            brandsElapsed = false
            categoriesElapsed = true
            productsElapsed = false
            
            brandsDoneBtn.setTitle("Edit", for: .normal)
            categoriesDoneBtn.setTitle("Done", for: .normal)
            productsDoneBtn.setTitle("Edit", for: .normal)
            
            categoryV.frame = CGRect(x: 10, y: brandsV.frame.maxY + 10, width: self.view.frame.width - 20, height: self.view.frame.maxY - brandsV.frame.maxY - 20)
            
            categoriesCV.frame = CGRect(x: 10, y: 25, width: self.view.frame.width - 30, height: categoryV.frame.height - 35)
            
            productsV.frame = CGRect(x: productsV.frame.minX, y: categoryV.frame.maxY + 10, width: productsV.frame.width, height: 25)
        }
        
        
        
        self.categoriesCV.reloadData()

        
    }
    
    @IBAction func productSelectDoneOnClick(_ sender: Any) {
        
    }
}

extension QA_ProductsVC: UICollectionViewDelegate, UICollectionViewDataSource, BrandCellDelegate, CategoryCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case brandsCV:
            break
        case categoriesCV:
            break
        case productsCV:
            break
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case brandsCV:
            if brandsElapsed {
                return brandsArr.count
            }
            else{
                return brandsSelArr.count
            }
        case categoriesCV:
            return categoriesFilteredArr.count
            
        case productsCV:
            return productsArr.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case brandsCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandCell", for: indexPath) as! BrandCVCell
            
            
            if brandsElapsed {
                
                cell.picIV.sd_setImage(with: URL(string: brandsArr[indexPath.row].image), placeholderImage: UIImage(named: "box_icon"))
                
                cell.brandCellDelegate = self
                cell.tag = brandsArr[indexPath.row].id
                
                cell.checkBox.isEnabled = true
                cell.checkBox.isUserInteractionEnabled = true
                
                if brandsSelArr.contains(where: {$0 == brandsArr[indexPath.row].id}){
                    cell.checkBox.isSelected = true
                }
                else{
                    cell.checkBox.isSelected = false
                }
            }
            else{
                
                let brand = realm.objects(Brand.self).filter("id == " + "\(brandsSelArr[indexPath.row])").first
                
                cell.checkBox.isSelected = true
                
                cell.picIV.sd_setImage(with: URL(string: (brand?.image)!), placeholderImage: UIImage(named: "box_icon"))
                
                cell.checkBox.isUserInteractionEnabled = false
                
            }
            
            return cell
            
        case categoriesCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCVCell
            
            cell.picIV.sd_setImage(with: URL(string: categoriesFilteredArr[indexPath.row].image), placeholderImage: UIImage(named: "box_icon"))
            
            cell.titleLbl.text = categoriesFilteredArr[indexPath.row].name
            
            cell.categoryCellDelegate = self
            cell.tag = categoriesFilteredArr[indexPath.row].id
            
            cell.checkBox.isEnabled = true
            cell.checkBox.isUserInteractionEnabled = true
            
            if categoriesSelArr.contains(where: {$0 == categoriesFilteredArr[indexPath.row].id}){
                cell.checkBox.isSelected = true
            }
            else{
                cell.checkBox.isSelected = false
            }
            
            return cell
        case productsCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCVCell
            
            cell.picIV.sd_setImage(with: URL(string: productsArr[indexPath.row].image), placeholderImage: UIImage(named: "box_icon"))
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func brandCheckBoxOnStateChanged(tag: Int, state: Bool) {
        
        if brandsSelArr.contains(where: {$0 == tag}) && !state && brandsElapsed{
            // it exists, do something
            
            brandsSelArr.remove(at: brandsSelArr.index(of: tag)!)
        }
        else if !brandsSelArr.contains(where: {$0 == tag}) && state && brandsElapsed{
            //item could not be found
            brandsSelArr.append(tag)
        }
        
        print("Brands Arr")
        print(brandsSelArr)
    }
    
    func categoryCheckBoxOnStateChanged(tag: Int, state: Bool) {
        
        if categoriesSelArr.contains(where: {$0 == tag}) && !state && categoriesElapsed{
            // it exists, do something
            
            categoriesSelArr.remove(at: categoriesSelArr.index(of: tag)!)
        }
        else if !categoriesSelArr.contains(where: {$0 == tag}) && state && categoriesElapsed{
            //item could not be found
            categoriesSelArr.append(tag)
        }
        
        print("Category Arr")
        print(categoriesSelArr)
    }
}
