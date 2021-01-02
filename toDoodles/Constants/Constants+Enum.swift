//
//  Constants+Enum.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 28/12/2020.
//

import UIKit

enum Constants {
    
    enum Strings {
        
        enum Title {
            static let createMainTask       = "Create main task"
            static let createSubTask        = "Create sub task"
            static let oops                 = "Oops"
            static let congrats             = "Congratulations"
            static let delete               = "Delete"
            static let moveToIncomplete     = "Move to incomplete"
        }
        
        enum Header {
            static let addThreeTasks        = "Add up to 3 sub tasks 🙂"
        }
        
        enum Message {
            static let placeholder          = "Start writing your task here"
            static let noTasksForToday      = "You don't have any tasks set out for today, add some right now 👍"
            static let maxSubTasks          = "Looks like you've reached the most amount of sub tasks you can have"
            static let addSubTasks          = "Add up to 3 sub tasks to help you complete you main task 👍"
            static let allTasksCompleted    = "You have completed all of your sub tasks. We will mark your main task as complete and you can find it in History."
            static let noCompletedTasks     = "You havent completed any tasks today, set some right now and get em done"
        }
        
        enum ButtonText {
            static let addTask              = "Add task"
            static let ok                   = "Ok"
        }
        
        enum Label {
            static let undo                 = "Undo"
            static let completed            = "Completed"
            static let pending              = "Pending"
            static let pieChartDescription  = "Completed vs Pending tasks"
        }
    }
    
    
    enum SystemImage {
        static let scribbleVariable         = UIImage(systemName:"scribble.variable")
        static let arrowUturnBackward       = UIImage(systemName: "arrow.uturn.backward")
        static let plus                     = UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        static let chevronFill              = UIImage(systemName: "chevron.forward.square.fill")
        static let circle                   = UIImage(systemName: "circle")
        static let fillCircle               = UIImage(systemName: "largecircle.fill.circle")
        static let edit                     = UIImage(systemName: "rectangle.and.pencil.and.ellipsis")
        static let chevronBackward          = UIImage(systemName: "chevron.backward")
    }
    
    
    enum ElementKind {
        static let badge                    = "badge"
        static let badgeElement             = "badge-element"
    }
    
    
    enum EntityName {
        static let subTask                  = "SubTask"
        static let task                     = "Task"
    }
    
    
    enum ReuseIdentifier {
        static let badgeReuseID             = "badge-reuse-identifier"
        static let taskCellReuseID          = "taskCellID"
        static let subTaskCellReuseID       = "subTaskCellID"
    }
    
}
