//
//  BaseFont.swift
//  Fuses
//
//  Created by iMac on 10/13/15.
//  Copyright (c) 2015 oci. All rights reserved.
//

import UIKit

extension UIFont
{
    static var fontFamily: String {
        get {
            return "Futura"
        }
    }
    
    public class func defaultFont(size: CGFloat) -> UIFont?
    {
        return UIFont(name: fontFamily , size: size)
    }
    
}
