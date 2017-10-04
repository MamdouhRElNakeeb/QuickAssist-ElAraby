//
//  OrderTVCell.swift
//  quick-assist
//
//  Created by Mamdouh El Nakeeb on 10/4/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import UIKit
import DropDown

class OrderTVCell: UITableViewCell {

    let productNameLbl = UILabel()
    let quantityDD = DropDown()
    let priceLbl = UILabel()
    let priceValueLbl = UILabel()
    let removeBtn = UIButton()
    
    weak var orderRemoveOnClick: OrderCellDelegate?
    
    let screenWidth = UIScreen.main.bounds.width
    let cellHeight: CGFloat = 34
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        productNameLbl.frame = CGRect(x: 10, y: 0, width: contentView.frame.width / 2 - 20, height: cellHeight)
        productNameLbl.font = UIFont(name: productNameLbl.font.fontName, size: 12)
        productNameLbl.font = UIFont.boldSystemFont(ofSize: productNameLbl.font.pointSize)
        
        removeBtn.frame = CGRect(x: contentView.frame.width - 15, y: 0, width: 10, height: cellHeight)
        removeBtn.setTitle("X", for: .normal)
        removeBtn.setTitleColor(UIColor.blue, for: .normal)
        
        priceValueLbl.frame = CGRect(x: removeBtn.frame.minX - 85, y: 0, width: 80, height: cellHeight)
        
        priceValueLbl.font = UIFont(name: priceLbl.font.fontName, size: 12)
        priceValueLbl.textColor = UIColor.blue
        priceValueLbl.textAlignment = .right
        
        priceLbl.frame = CGRect(x: priceValueLbl.frame.minX - 50, y: 0, width: 50, height: cellHeight)
        priceLbl.text = "Price:"
        priceLbl.font = UIFont(name: priceLbl.font.fontName, size: 12)
        priceLbl.textAlignment = .right
        
        quantityDD.frame = CGRect(x: priceLbl.frame.minX - 30, y: 0, width: 30, height: cellHeight)
        quantityDD.anchorView = self.contentView
        quantityDD.dataSource = ["1", "2", "3", "4", "5"]
        quantityDD.direction = .any
        quantityDD.dismissMode = .onTap
        
        removeBtn.addTarget(self, action: #selector(removeProduct), for: .touchUpInside)
        
        self.contentView.addSubview(quantityDD)
        self.contentView.addSubview(productNameLbl)
        self.contentView.addSubview(priceLbl)
        self.contentView.addSubview(priceValueLbl)
        self.contentView.addSubview(removeBtn)
        
    }
    
    func removeProduct (){
        
        orderRemoveOnClick?.orderRemoveOnClick(tag: self.tag)
    }
}

protocol OrderCellDelegate: class {
    
    func orderRemoveOnClick(tag: Int)
}
