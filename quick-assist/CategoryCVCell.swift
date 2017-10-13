//
//  CategoryCell.swift
//  quick-assist
//
//  Created by Mamdouh El Nakeeb on 9/26/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import UIKit
import SDWebImage
import UICheckbox_Swift

class CategoryCVCell: UICollectionViewCell {
 
    let picIV = UIImageView()
    let titleLbl = UILabel()
    let checkBox = UICheckbox()
    let subBtn = UIButton()
    
    let subsGreyView = UIView()
    let subCategoriesCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var subCategoriesArr = Array<Category>()
    var subCategoriesSelArr = Array<Int>()
    
    var subCatExpanded = false
    var checked = false
    
    let screenWidth = UIScreen.main.bounds.width - 40
    
    weak var categoryCellDelegate : CategoryCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let greyView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        greyView.backgroundColor = UIColor.greyLightColor()
        
        checkBox.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        checkBox.backgroundColor = UIColor.white
        checkBox.isSelected = false
        
        checkBox.onSelectStateChanged = { (checkbox, selected) in
            
            self.categoryCellDelegate?.categoryCheckBoxOnStateChanged(tag: self.tag, state: self.checkBox.isSelected)
            
        }
        
        greyView.addSubview(checkBox)
        
        // Subs Button
        subBtn.frame = CGRect(x: screenWidth - 50, y: 10, width: 45, height: 20)
        subBtn.setTitle("Subs <", for: .normal)
        subBtn.setTitleColor(UIColor.black, for: .normal)
        subBtn.titleLabel?.font = UIFont(name: (subBtn.titleLabel?.font.fontName)!, size: 14)
        subBtn.addTarget(self, action: #selector(toggleSubCategories), for: .touchUpInside)
        
        
        
        
        picIV.frame = CGRect(x: 45, y: 5, width: 40, height: 35)
        picIV.contentMode = .scaleAspectFit
        picIV.layer.masksToBounds = true
        
        titleLbl.frame = CGRect(x: picIV.frame.maxX + 10, y: 0, width: screenWidth - picIV.frame.maxX, height: 40)
        titleLbl.textColor = UIColor.black
        titleLbl.font = UIFont.systemFont(ofSize: 14)
        
        
        // Details Expandable Layout
        subsGreyView.frame = CGRect(x: greyView.frame.maxX, y: picIV.frame.maxY, width: screenWidth, height: 0)
        subsGreyView.backgroundColor = UIColor.greyLightColor()
        
        
        initSubCatagoriesCV()
        
        subsGreyView.addSubview(subCategoriesCV)
        
        // Add to the parent view
        contentView.addSubview(greyView)
        contentView.addSubview(picIV)
        contentView.addSubview(titleLbl)
        contentView.addSubview(subsGreyView)
        contentView.addSubview(subBtn)
        
        contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initSubCatagoriesCV(){
        let itemSize = contentView.frame.width - 65
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSize(width: itemSize, height: 40)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        subCategoriesCV.dataSource = self
        subCategoriesCV.delegate = self
        
        subCategoriesCV.setCollectionViewLayout(flowLayout, animated: true)
        subCategoriesCV.register(SubCategoryCVCell.self, forCellWithReuseIdentifier: "subCategoryCell")
        
    
        subCategoriesCV.frame = CGRect(x: 40
            , y: 0, width: contentView.frame.width - 60, height: subsGreyView.frame.height - 20)
        
        subCategoriesCV.layer.masksToBounds = true
        
        subCategoriesCV.backgroundColor = UIColor.white
        
    }
    
    func toggleSubCategories (){
        
        if subCatExpanded {
            
            subCatExpanded = false
            
        }
        else{
            
            subCatExpanded = true
            
        }
        
        categoryCellDelegate?.subCategoriesExpanded(tag: self.tag, state: subCatExpanded)
        
    }
    
}

protocol CategoryCellDelegate : class {
    func categoryCheckBoxOnStateChanged(tag: Int, state: Bool)
    func subCategoriesExpanded(tag: Int, state: Bool)
}

extension CategoryCVCell: UICollectionViewDataSource, UICollectionViewDelegate, SubCategoryCellDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCategoriesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subCategoryCell", for: indexPath) as! SubCategoryCVCell
        
        cell.picIV.sd_setImage(with: URL(string: subCategoriesArr[indexPath.row].image), placeholderImage: UIImage(named: "box_icon"))
        cell.titleLbl.text = subCategoriesArr[indexPath.row].name
        
        cell.subCategoryCellDelegate = self
        cell.tag = subCategoriesArr[indexPath.row].id
        
        // Check Selected Categories
        if subCategoriesSelArr.contains(where: {$0 == subCategoriesArr[indexPath.row].id}){
            cell.checkBox.isSelected = true
        }
        else{
            cell.checkBox.isSelected = false
        }


        return cell
    }
    
    func subCategoryCheckBoxOnStateChanged(tag: Int, state: Bool) {
        
        self.categoryCellDelegate?.categoryCheckBoxOnStateChanged(tag: tag, state: state)
        
    }
    
    
}

