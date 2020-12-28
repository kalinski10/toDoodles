//
//  DataControllerManager.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 16/12/2020.
//

import UIKit
import CoreData

class DataControllerManager {

    static let shared   = DataControllerManager()
    let context         = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private init() {}
    
    
    func fetchTasks(completed: (Result<[Task], TDError>) -> Void) {
        do {
            var tasks: [Task] = try context.fetch(Task.fetchRequest())
            
            if tasks.isEmpty {
                completed(.failure(.weHaveAnError))
                return
            }
            
            tasks.sort { $0.createdAt! > $1.createdAt! }
            completed(.success(tasks))
        }
        catch {
            completed(.failure(.weHaveAnError))
            print("something went wronrg while trying to retrieve your tasks.")
        }
    }
    
    
    func fetchSubTasks(mainTask: Task, completed: (Result<[SubTask], TDError>) -> Void) {
        
        do {
            let tasks: [SubTask]    = try context.fetch(SubTask.fetchRequest())
            let filteredTasks       = tasks.filter { $0.mainTask == mainTask}
            if filteredTasks.isEmpty {
                completed(.failure(.weHaveAnError))
                return
            }
            completed(.success(filteredTasks))
        }
        catch {
            completed(.failure(.weHaveAnError))
            print("something went wronrg while trying to retrieve your tasks.")
        }
    }


    func saveTasks() {
        do { try context.save() }
        catch { print("something went wrong while tring to save your changes. 😔") }
    }
    
    
}
