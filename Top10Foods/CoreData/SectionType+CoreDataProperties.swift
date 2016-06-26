//
//  SectionType+CoreDataProperties.swift
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

extension SectionType {

    @NSManaged var color: String?
    @NSManaged var likes: NSNumber?
    @NSManaged var name: String?
    @NSManaged var recepies: NSSet?

}
