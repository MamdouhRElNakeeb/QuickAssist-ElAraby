//
//  FollowUpCell.swift
//  quick-assist
//
//  Created by HANHON on 10/8/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import UIKit

class FollowUpCell: UITableViewCell {

    let productsLbl = UILabel()
    let categoryLbl = UILabel()
    let brandLbl = UILabel()
    let dateLbl = UILabel()
    let priceValueLbl = UILabel()
    let nameLbl = UILabel()
    let statusLbl = UILabel()
    let harryUpBtn = UIButton()
    
    // brand, category
    // name,
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: 150)
        let bg = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        bg.backgroundColor = UIColor.white
        
        let itemWidth = contentView.frame.width - 20
        
        productsLbl.frame = CGRect(x: 10, y: 10, width: itemWidth, height: 21)
        productsLbl.font = UIFont.boldSystemFont(ofSize: 15)
        productsLbl.textColor = UIColor.black
        
        categoryLbl.frame = CGRect(x: productsLbl.frame.minX, y: productsLbl.frame.maxY, width: itemWidth, height: 21)
        categoryLbl.font = UIFont(name: categoryLbl.font.fontName, size: 13)
        categoryLbl.textColor = UIColor.darkGray
        
        brandLbl.frame = CGRect(x: categoryLbl.frame.minX, y: categoryLbl.frame.maxY, width: itemWidth, height: 21)
        brandLbl.font = categoryLbl.font
        brandLbl.textColor = categoryLbl.textColor
        
        dateLbl.frame = CGRect(x: brandLbl.frame.minX, y: brandLbl.frame.maxY, width: itemWidth, height: 21)
        dateLbl.font = categoryLbl.font
        dateLbl.textColor = categoryLbl.textColor
        
        let priceLbl = UILabel(frame: CGRect(x: dateLbl.frame.minX, y: dateLbl.frame.maxY, width: 30, height: 21))
        priceLbl.font = dateLbl.font
        priceLbl.textColor = dateLbl.textColor
        priceLbl.text = "Price: "
        
        priceValueLbl.frame = CGRect(x: priceLbl.frame.maxX, y: priceLbl.frame.minY, width: itemWidth - priceLbl.frame.maxX, height: 21)
        priceValueLbl.font = categoryLbl.font
        priceValueLbl.textColor = UIColor.blue()
        
        nameLbl.frame = CGRect(x: priceLbl.frame.minX, y: priceLbl.frame.maxY, width: itemWidth, height: 21)
        nameLbl.font = categoryLbl.font
        nameLbl.textColor = categoryLbl.textColor
        
        statusLbl.frame = CGRect(x: nameLbl.frame.minX, y: nameLbl.frame.maxY, width: itemWidth, height: 21)
        statusLbl.font = categoryLbl.font
        statusLbl.textColor = categoryLbl.textColor
        
        harryUpBtn.frame = CGRect(x: itemWidth - 130, y: bg.frame.height - 50, width: 120, height: 40)
        
        bg.addSubview(productsLbl)
        bg.addSubview(categoryLbl)
        bg.addSubview(brandLbl)
        bg.addSubview(dateLbl)
        bg.addSubview(priceLbl)
        bg.addSubview(priceValueLbl)
        bg.addSubview(statusLbl)
        
    }

}
