//
//  DatabaseManager.swift
//  Top10Foods
//
//  Created by admin on 6/5/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseManager {
    
    static let sharedDatabase = DatabaseManager()
    
    private var dbContext: NSManagedObjectContext? = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    private var recepies = NSArray()
    
    private func parsePlists() -> [Dictionary<String, AnyObject>] {
        
        var result = [Dictionary<String, AnyObject>]()
        if let path = NSBundle.mainBundle().pathForResource("FoodRecepies", ofType: "plist") {
            if let recepies = NSArray(contentsOfFile: path) as? [Dictionary<String, AnyObject>] {
                result = recepies
            }
        }
        return result
    }
    
    func parseRecepiesIfNeeded () {
        
        let nsUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if !nsUserDefaults.boolForKey("hasLaunchedOnce") {
            parseSections(parsePlists())
            nsUserDefaults.setBool(true, forKey: "hasLaunchedOnce")
            nsUserDefaults.synchronize()
        }
    }
}


//parse
extension DatabaseManager {
    
    private func parseSections (sections : [Dictionary<String, AnyObject>]) {
        
        if let db = dbContext {
            
            for section in sections {
                
                if let name = section["Name"] as? String,
                    let likes = section["Likes"] as? Int,
                    let recepies = section["Recepies"] as? [Dictionary<String, String>],
                    let color = section["Color"] as? String {
                    
                    if let sectionObj: SectionType = NSEntityDescription.insertNewObjectForEntityForName("SectionType", inManagedObjectContext: db) as? SectionType {
                    
                        sectionObj.name = name
                        sectionObj.likes = likes
                        sectionObj.color = color
                        sectionObj.recepies = NSSet(array: getRecepies(recepies , db: db))
                    }
                }
                do {
                    try db.save()
                } catch {
                    print("Database fail to parse objects, error: \(error)")
                }
            }
        }
    }
    
    private func getRecepies (recepies : [Dictionary<String, String>], db : NSManagedObjectContext) -> [Recepies] {
        var result:[Recepies] = [Recepies]()

        for recipe in recepies {
            
            if let level = recipe["level"],
                let ingredients = recipe["ingredients"],
                let name = recipe["name"],
                let time = recipe["time"],
                let searchWords = recipe["searchWords"],
                let serving = recipe["serving"],
                let type = recipe["type"] {
                
                if let recipeObj: Recepies = NSEntityDescription.insertNewObjectForEntityForName("Recepies", inManagedObjectContext: db) as? Recepies {
                    
                    recipeObj.name = name
                    recipeObj.ingredients = ingredients
                    recipeObj.level = level
                    recipeObj.time = time
                    recipeObj.searchWords = searchWords
                    recipeObj.serving = serving
                    recipeObj.type = type
                    
                    result.append(recipeObj)
                }
            }
        }
        return result
    }
}

//fetch
extension DatabaseManager {
    
    func getSectionTypes() -> [SectionType]? {
        return self.fetchRecordsFromEntity("SectionType") as? [SectionType]
    }
    
    private func fetchRecordsFromEntity(entityName: String) -> Array<AnyObject>? {
        var objects: Array<AnyObject>?
        if let db = dbContext {
            let request: NSFetchRequest = NSFetchRequest()
            request.entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: db)
            do {
                let result = try db.executeFetchRequest(request)
                
                objects = result
            } catch {
                print("error :\(error)")
            }
        }
        return objects
    }
}





