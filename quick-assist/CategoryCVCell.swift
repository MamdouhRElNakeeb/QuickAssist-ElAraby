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
        
        // Add to the parent view
        contentView.addSubview(greyView)
        
        
        picIV.frame = CGRect(x: 45, y: 5, width: 40, height: 35)
        picIV.contentMode = .scaleAspectFit
        picIV.layer.masksToBounds = true
        
        titleLbl.frame = CGRect(x: picIV.frame.maxX + 10, y: 0, width: screenWidth - picIV.frame.maxX, height: 40)
        titleLbl.textColor = UIColor.black
        
        contentView.addSubview(picIV)
        contentView.addSubview(titleLbl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

protocol CategoryCellDelegate : class {
    func categoryCheckBoxOnStateChanged(tag: Int, state: Bool)
}

