//
//  SectionType.swift
//  
//
//  Created by admin on 6/5/16.
//
//

import Foundation
import CoreData


class SectionType: NSManagedObject {
    
    private static let sectionFilterOpacity: CGFloat = 0.3

    static func getColors (recepies : [SectionType]) -> [UIColor] {
        
        var result = [UIColor]()
        
        for recipe in recepies {
            
            if let color = recipe.color {
                
                let colorArray = color.characters.split {$0 == ","}.map { String($0) }
                
                if let redValue = Int(colorArray[0]),
                    let greenValue = Int(colorArray[1]),
                    let blueValue = Int(colorArray[2]) {
                    
                    result.append(UIColor(red: CGFloat(redValue)/255, green: CGFloat(greenValue)/255 , blue: CGFloat(blueValue)/255, alpha: sectionFilterOpacity))
                    
                }
            }
        }
        return result
    }

}
