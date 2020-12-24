//
//  CreateMainTaskVC.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 14/12/2020.
//

import UIKit

protocol CreateMainTaskCellDelegate: AnyObject {
    func createMainTask()
}

class CreateMainTaskVC: CreateTaskVC {
    
    weak var mainDelegate: CreateMainTaskCellDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    

    override func addTask() {
        guard let taskString = textField.text else { return }
        
        createNewTask(taskString: taskString)
        saveTask()
        
        mainDelegate?.createMainTask()
        dismiss(animated: true)
    }
    
    
    func configureVC() {
        titleLabel.text = "Create main task"
    }
    
}
