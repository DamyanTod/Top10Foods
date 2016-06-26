//
//  ColorEnum.swift
//  Top10Foods
//
//  Created by admin on 6/5/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation


enum ColorEnum : Int {
    
    case WhiteColor = 0
    case BlackColor
    case BackgroundColor
    
    static func getColorForEnum (colorEnum: ColorEnum) -> [String : AnyObject]? {
        
        var result:[String : AnyObject]?
        
        let shadow = NSShadow();
        
        shadow.shadowOffset = CGSizeMake(1,2);
        
        switch colorEnum {
        case .WhiteColor:
            shadow.shadowColor = UIColor.blackColor();
            result = NSDictionary(objects: [UIColor.whiteColor(), shadow], forKeys: [NSForegroundColorAttributeName, NSShadowAttributeName]) as? [String : AnyObject];
        case .BlackColor:
            shadow.shadowColor = UIColor.whiteColor();
            result = NSDictionary(objects: [UIColor.blackColor(), shadow], forKeys: [NSForegroundColorAttributeName, NSShadowAttributeName]) as? [String : AnyObject];
        case .BackgroundColor:
            shadow.shadowColor = UIColor.whiteColor();
            result = NSDictionary(objects: [UIColor.defaultBackgroundColor()!, shadow], forKeys: [NSForegroundColorAttributeName, NSShadowAttributeName]) as? [String : AnyObject];
        }
        
        return result
    }

  
}

