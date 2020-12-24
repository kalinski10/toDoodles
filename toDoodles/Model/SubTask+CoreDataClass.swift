//
//  SubTask+CoreDataClass.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 18/12/2020.
//
//

import Foundation
import CoreData

@objc(SubTask)
public class SubTask: NSManagedObject {
    var completion: Completed {
        get { Completed(rawValue: Int(completionEnum)) ?? .pending}
        set { completionEnum = Int64(newValue.rawValue)}
    }
}
