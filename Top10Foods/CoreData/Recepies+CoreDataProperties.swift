//
//  Recepies+CoreDataProperties.swift
//  
//
//  Created by admin on 6/5/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Recepies {

    @NSManaged var type: String?
    @NSManaged var ingredients: String?
    @NSManaged var level: String?
    @NSManaged var name: String?
    @NSManaged var searchWords: String?
    @NSManaged var serving: String?
    @NSManaged var time: String?
    @NSManaged var relationship: SectionType?

}
