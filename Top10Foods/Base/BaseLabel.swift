//
//  BaseLabel.swift
//  Fuses
//
//  Created by iMac on 10/9/15.
//  Copyright (c) 2015 oci. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    
    override func awakeFromNib() {
        
        let size = self.font.pointSize
        
        self.layer.cornerRadius = 8
        
        self.clipsToBounds = true
    
        self.font = UIFont.defaultFont(size)
        
    }
    
    func setAttributedBaseText (text:String) {
        
        let attributes = ColorEnum.getColorForEnum(ColorEnum(rawValue: self.tag)!)
        
        self.attributedText = NSAttributedString(string: text , attributes: attributes)
        
    }
}
