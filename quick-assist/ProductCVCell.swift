//
//  ProductCell.swift
//  quick-assist
//
//  Created by Mamdouh El Nakeeb on 9/26/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import UIKit
import SDWebImage
import UICheckbox_Swift

class ProductCVCell: UICollectionViewCell {
    
    let picIV = UIImageView()
    let titleLbl = UILabel()
    let priceLbl = UILabel()
    let checkBox = UICheckbox()
    let infoBtn = UIButton()
    
    let detailsGreyView = UIView()
    let detailsLbl = UILabel()
    var infoExpanded = false
    
    let shareBtn = UIButton()
    
    let screenWidth = UIScreen.main.bounds.width - 40
    
    
    weak var productCellDelegate : ProductCellDelegate?
    
    /* 
     * height: 97
     * expandedHeight:
     */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Checkbox
        let greyView = UIView(frame: CGRect(x: screenWidth - 30, y: 40, width: 30, height: 30))
        greyView.backgroundColor = UIColor.greyLightColor()
        
        checkBox.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        checkBox.backgroundColor = UIColor.white
        checkBox.isSelected = false
        
        checkBox.onSelectStateChanged = { (checkbox, selected) in
            
            self.productCellDelegate?.productCheckBoxOnStateChanged(tag: self.tag, state: self.checkBox.isSelected)
            
        }
        
        greyView.addSubview(checkBox)
        
        // Info Button
        infoBtn.frame = CGRect(x: screenWidth - 50, y: 10, width: 45, height: 20)
        infoBtn.setTitle("Info <", for: .normal)
        infoBtn.setTitleColor(UIColor.black, for: .normal)
        infoBtn.titleLabel?.font = UIFont(name: (infoBtn.titleLabel?.font.fontName)!, size: 14)
        infoBtn.addTarget(self, action: #selector(toggleInfo), for: .touchUpInside)
        
        // Product Image
        picIV.frame = CGRect(x: 10, y: 10, width: 77, height: 77)
        picIV.contentMode = .scaleAspectFit
        picIV.layer.masksToBounds = true
        
        // Product Title
        titleLbl.font = UIFont(name: titleLbl.font.fontName, size: 13)
        titleLbl.frame = CGRect(x: picIV.frame.maxX + 5, y: 10, width: infoBtn.frame.minX - picIV.frame.maxX - 15, height: 20)
        titleLbl.textColor = UIColor.black
        titleLbl.font = UIFont.boldSystemFont(ofSize: titleLbl.font.pointSize)
        
        // Product Price
        priceLbl.font = UIFont(name: priceLbl.font.fontName, size: 12)
        priceLbl.frame = CGRect(x: titleLbl.frame.minX, y: titleLbl.frame.maxY, width: infoBtn.frame.minX - picIV.frame.maxX - 15, height: 20)
        priceLbl.textColor = UIColor.gray
        
        // Details Expandable Layout
        detailsGreyView.frame = CGRect(x: 0, y: picIV.frame.maxY, width: screenWidth, height: 0)
        detailsGreyView.backgroundColor = UIColor.greyMidColor()
        
        let detailsHeader = UILabel(frame: CGRect(x: 10, y: 10, width: detailsGreyView.frame.width - 20, height: 10))
        detailsHeader.textColor = UIColor.black
        detailsHeader.font = UIFont(name: detailsLbl.font.fontName, size: 12)
        detailsHeader.font = UIFont.boldSystemFont(ofSize: detailsHeader.font.pointSize)
        detailsHeader.text = "Details"
        
        detailsLbl.frame = CGRect(x: 10, y: detailsHeader.frame.maxY, width: detailsGreyView.frame.width - 20, height: 0)
        detailsLbl.textColor = UIColor.black
        detailsLbl.font = UIFont(name: detailsLbl.font.fontName, size: 12)
        detailsLbl.numberOfLines = 8
        
        detailsGreyView.addSubview(detailsHeader)
        detailsGreyView.addSubview(detailsLbl)
        
        // Share Button
        shareBtn.frame = CGRect(x: picIV.frame.maxX + 10, y: picIV.frame.maxY - 20, width: greyView.frame.minX - picIV.frame.maxX, height: 10)
        let shareImg = UIImageView(image: UIImage(named: "share_icon"))
        shareImg.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        
        let shareLbl = UILabel(frame: CGRect(x: shareImg.frame.maxX + 5, y: 0, width: shareBtn.frame.width - 20, height: 15))
        shareLbl.text = "Share"
        shareLbl.textColor = UIColor.black
        shareLbl.font = UIFont(name: shareLbl.font.fontName, size: 13)
        
        shareBtn.addSubview(shareImg)
        shareBtn.addSubview(shareLbl)
        
        shareBtn.addTarget(self, action: #selector(shareBtnOnClick), for: .touchUpInside)
        
        // Add to the parent view
        contentView.addSubview(greyView)
        contentView.addSubview(picIV)
        contentView.addSubview(titleLbl)
        contentView.addSubview(priceLbl)
        contentView.addSubview(shareBtn)
        contentView.addSubview(infoBtn)
        contentView.addSubview(detailsGreyView)
        
        contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggleInfo (){
        
        if infoExpanded {
            
            infoExpanded = false
 
        }
        else{
            
            infoExpanded = true
 
        }
        
        productCellDelegate?.productInfoExpanded(tag: self.tag, state: infoExpanded)
        
    }
    
    func shareBtnOnClick(){
        productCellDelegate?.productShare(tag: self.tag)
    }
    
}

protocol ProductCellDelegate : class {
    func productCheckBoxOnStateChanged(tag: Int, state: Bool)
    func productInfoExpanded(tag: Int, state: Bool)
    func productShare(tag: Int)
}

