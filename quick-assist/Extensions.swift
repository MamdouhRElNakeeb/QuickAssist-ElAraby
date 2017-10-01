//
//  Extensions.swift
//  quick-assist
//
//  Created by Mamdouh El Nakeeb on 9/25/17.
//  Copyright © 2017 ElAraby Group. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func primaryColor() -> UIColor {
        
        return UIColor(red: 74/255, green: 174/255, blue: 106/255, alpha: 1)
    }
    
    class func secondryColor() -> UIColor {
        
        return UIColor(red: 184/255, green: 209/255, blue: 36/255, alpha: 1)
    }
    
    class func greyLightColor() -> UIColor {
        
        return UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    }
}

extension String {
    func indexOf(string: String) -> Int {
        
        var index = Int()
        let searchStartIndex = self.startIndex
        
        while searchStartIndex < self.endIndex,
            let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
            !range.isEmpty
        {
            index = distance(from: self.startIndex, to: range.lowerBound)
            break
        }
        
        return index
    }
}
