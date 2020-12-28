//
//  SubTask+CoreDataProperties.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 18/12/2020.
//
//

import Foundation
import CoreData


extension SubTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubTask> {
        return NSFetchRequest<SubTask>(entityName: Constants.EntityName.subTask)
    }

    @NSManaged public var body: String?
    @NSManaged public var completionEnum: Int64
    @NSManaged public var mainTask: Task?

}

extension SubTask : Identifiable {

}
