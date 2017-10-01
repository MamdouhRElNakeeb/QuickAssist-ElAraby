//
//  BrandCVCell.swift
//  quick-assist
//
//  Created by Mamdouh El Nakeeb on 9/17/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import UIKit
import SDWebImage
import UICheckbox_Swift

class BrandCVCell: UICollectionViewCell {
    
    let picIV = UIImageView()
    let checkBox = UICheckbox()
    
    let screenWidth = UIScreen.main.bounds.width - 40
    
    weak var brandCellDelegate : BrandCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let greyView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        greyView.backgroundColor = UIColor.greyLightColor()
        
        checkBox.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        checkBox.backgroundColor = UIColor.white
        //checkBox.isSelected = false
        
        checkBox.onSelectStateChanged = { (checkbox, selected) in
            
            self.brandCellDelegate?.brandCheckBoxOnStateChanged(tag: self.tag, state: self.checkBox.isSelected)
            
        }
        
        //let scView = SuccessCheck(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        
        greyView.addSubview(checkBox)
        
        // Add to the parent view
        contentView.addSubview(greyView)
        
        // Animate the tick process
        /*scView.initWithTime(withDuration: 0, bgCcolor: .white, colorOfStroke: .blue, widthOfTick: 2) {
            //do additional work after completion
        }*/
        
        picIV.frame = CGRect(x: 40, y: 5, width: (screenWidth / 2) - 40, height: 35)
        picIV.contentMode = .scaleAspectFit
        picIV.layer.masksToBounds = true
        
        contentView.addSubview(picIV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol BrandCellDelegate : class {
    func brandCheckBoxOnStateChanged(tag: Int, state: Bool)
}

