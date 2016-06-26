//
//  ParseModel.swift
//  Top10Foods
//
//  Created by admin on 11/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

import Foundation


class ParseModel {
    
    static func getCountryName (recepies : [PFObject]?) -> String {
        var result = ""
        var isMoreThanOnes = false
        
        if let recepies = recepies {
            
            for recipe in recepies {
                
                if let country = recipe.objectForKey("Country") as? PFObject ,
                    let name = country.valueForKey("CountryName") as? String {
                        
                        if !isMoreThanOnes {
                            isMoreThanOnes = true
                            result = name
                        }
                }
            }
        }
        return result
    }
    
    static func getAllRecepies (callback: (allObjects: [PFObject]?)->()) {
        
        let query = PFQuery(className:"Recipe")
        
        query.limit = 500
        query.includeKey("Country")
        
        query.findObjectsInBackgroundWithBlock { (objects, error : NSError?) -> Void in
                
            var result: [PFObject]?
                
            if let objects = objects {
                result = objects
            }
                callback(allObjects: result)
        }
        
    }
    
    
    static func getColors (recepies : [PFObject]) -> [String:UIColor] {
        
        var result = [String:UIColor]()
        
        for recipe in recepies {
            
            if let country = recipe.objectForKey("Country") as? PFObject ,
                let name = country.valueForKey("CountryName") as? String ,
                let color = country.valueForKey("Color") as? String {
                    
                    let colorArray = color.characters.split {$0 == ","}.map { String($0) }
                    
                    //we have this values in Parse.com class Country ...
                    
                    if let redValue = Int(colorArray[0]),
                        let greenValue = Int(colorArray[1]),
                        let blueValue = Int(colorArray[2]) {
                
                            if result[name] == nil {
                                result[name] = UIColor(red: CGFloat(redValue)/255, green: CGFloat(greenValue)/255 , blue: CGFloat(blueValue)/255, alpha: 0.4)
                            }
                    }
            }
        }
   
        return result
    }
    
    
    static func getRecipesForCountry (recepies : [PFObject], countryName : String) -> [PFObject] {
        
        var result = [PFObject]()
        
        for recipe in recepies {
            
            if let country = recipe.objectForKey("Country") as? PFObject ,
                let name = country.valueForKey("CountryName") as? String {
                
                    if name == countryName {
                        result.append(recipe)
                    }
            }
        
        }
   
        return result
    }
    
}
