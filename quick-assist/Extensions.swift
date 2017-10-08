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
    
    class func greyMidColor() -> UIColor {
        
        return UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
    }
    
    class func blue() -> UIColor {
        
        return UIColor(red: 48/255, green: 73/255, blue: 153/255, alpha: 1)
    }
}

extension String {
    
    // Get Index of specific char in a String
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
    
    // Convert HTML to Attributed String
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return nil
        }
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
}

extension UIImage{
    
    class func textToImage(drawText text: String, imgFrame frame: CGRect) -> UIImage {
        
        let image = UIImage(named: "")
        
        let viewToRender = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        
        let imgView = UIImageView(frame: viewToRender.frame)
        
        imgView.image = image
        
        viewToRender.addSubview(imgView)
        
        let textImgView = UIImageView(frame: viewToRender.frame)
        
        textImgView.image = imageFrom(text: text, frame: frame)
        
        viewToRender.addSubview(textImgView)
        
        UIGraphicsBeginImageContextWithOptions(viewToRender.frame.size, false, 0)
        viewToRender.layer.render(in: UIGraphicsGetCurrentContext()!)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return finalImage!
    }
    
    class func imageFrom(text: String , frame: CGRect) -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(size: frame.size)
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 17)!, NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: paragraphStyle]
            
            text.draw(with: CGRect(x: 0, y: 5, width: frame.width, height: frame.height), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
            
        }
        return img
    }
    
}
