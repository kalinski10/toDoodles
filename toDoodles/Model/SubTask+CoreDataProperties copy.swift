//
//  SubTask+CoreDataProperties.swift
//  
//
//  Created by Kalin Balabanov on 28/01/2021.
//
//

import Foundation
import CoreData


extension SubTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubTask> {
        return NSFetchRequest<SubTask>(entityName: "SubTask")
    }

    @NSManaged public var body: String?
    @NSManaged public var completionEnum: Int64
    @NSManaged public var mainTask: Task?

}
