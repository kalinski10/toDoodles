//
//  Task+CoreDataClass.swift
//  
//
//  Created by Kalin Balabanov on 28/01/2021.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    var completion: Completed {
            get { Completed(rawValue: Int(completionEnum)) ?? .pending}
            set { completionEnum = Int64(newValue.rawValue)}
        }
}
