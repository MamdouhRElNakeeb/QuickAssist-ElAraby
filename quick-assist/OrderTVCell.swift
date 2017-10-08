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
    let quantityBtn = UIButton()
    let priceLbl = UILabel()
    let priceValueLbl = UILabel()
    let removeBtn = UIButton()
    
    weak var orderRemoveOnClick: OrderCellDelegate?
    
    let screenWidth = UIScreen.main.bounds.width - 32
    let cellHeight: CGFloat = 35
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: cellHeight)
        
        productNameLbl.frame = CGRect(x: 10, y: 0, width: contentView.frame.width / 2 - 30, height: cellHeight)
        productNameLbl.font = UIFont(name: productNameLbl.font.fontName, size: 12)
        productNameLbl.font = UIFont.boldSystemFont(ofSize: productNameLbl.font.pointSize)
        
        removeBtn.frame = CGRect(x: contentView.frame.width - 20, y: 0, width: 15, height: cellHeight)
        removeBtn.setTitle("X", for: .normal)
        removeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        removeBtn.setTitleColor(UIColor.blue, for: .normal)
        
        priceValueLbl.frame = CGRect(x: removeBtn.frame.minX - 85, y: 0, width: 80, height: cellHeight)
        
        priceValueLbl.font = UIFont(name: priceLbl.font.fontName, size: 12)
        priceValueLbl.textColor = UIColor.blue
        priceValueLbl.textAlignment = .left
        
        priceLbl.frame = CGRect(x: priceValueLbl.frame.minX - 40, y: 0, width: 40, height: cellHeight)
        priceLbl.text = "Price:"
        priceLbl.font = UIFont(name: priceLbl.font.fontName, size: 12)
        priceLbl.textAlignment = .right
        
        quantityBtn.frame = CGRect(x: priceLbl.frame.minX - 20, y: 0, width: 20, height: cellHeight)
        quantityBtn.addTarget(self, action: #selector(showDropDown), for: .touchUpInside)
        
        quantityBtn.setTitle("1", for: .normal)
        quantityBtn.setTitleColor(UIColor.black, for: .normal)
        quantityBtn.backgroundColor = UIColor.greyLightColor()
        quantityBtn.titleLabel?.font = UIFont(name: (quantityBtn.titleLabel?.font.fontName)!, size: 13)
        
        quantityDD.frame = CGRect(x: priceLbl.frame.minX - 30, y: 0, width: 30, height: cellHeight)
        quantityDD.anchorView = quantityBtn
        quantityDD.dataSource = ["1", "2", "3", "4", "5"]
        quantityDD.direction = .any
        quantityDD.dismissMode = .onTap
        
        /*
        quantityDD.selectionAction = { [unowned self] (index, item) in
            
            self.quantityBtn.setTitle(item, for: .normal)
            
        }
        */
        
        removeBtn.addTarget(self, action: #selector(removeProduct), for: .touchUpInside)
        
        let whiteBG = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: cellHeight))
        whiteBG.backgroundColor = UIColor.white
        
        self.contentView.addSubview(whiteBG)
        self.contentView.addSubview(quantityBtn)
        self.contentView.addSubview(productNameLbl)
        self.contentView.addSubview(priceLbl)
        self.contentView.addSubview(priceValueLbl)
        self.contentView.addSubview(removeBtn)
        
    }
    
    func removeProduct (){
        
        orderRemoveOnClick?.orderRemoveOnClick(tag: self.tag)
    }
    
    func showDropDown (){
        quantityDD.show()
    }
}

protocol OrderCellDelegate: class {
    
    func orderRemoveOnClick(tag: Int)
}
