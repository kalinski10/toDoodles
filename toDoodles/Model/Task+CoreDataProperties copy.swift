//
//  Task+CoreDataProperties.swift
//  
//
//  Created by Kalin Balabanov on 28/01/2021.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var completionEnum: Int64
    @NSManaged public var createdAt: Date?
    @NSManaged public var taskDescription: String?
    @NSManaged public var subTask: NSSet?

}

// MARK: Generated accessors for subTask
extension Task {

    @objc(addSubTaskObject:)
    @NSManaged public func addToSubTask(_ value: SubTask)

    @objc(removeSubTaskObject:)
    @NSManaged public func removeFromSubTask(_ value: SubTask)

    @objc(addSubTask:)
    @NSManaged public func addToSubTask(_ values: NSSet)

    @objc(removeSubTask:)
    @NSManaged public func removeFromSubTask(_ values: NSSet)

}
