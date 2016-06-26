//
//  BaseColor.swift
//  Fuses
//
//  Created by iMac on 10/18/15.
//  Copyright (c) 2015 oci. All rights reserved.
//

import Foundation

extension UIColor {

    static var getGreenValue: CGFloat {
        get {
            return 46
        }
    }
    static var getRedValue : CGFloat {
        get {
            return 8
        }
    }
    static var getBlueValue : CGFloat {
        get {
            return 65
        }
    }

    public class func defaultBackgroundColor () -> UIColor?
    {
        return UIColor(red: getRedValue/255.0, green: getGreenValue/255.0, blue: getBlueValue/255.0, alpha: 1)
    }
 
}