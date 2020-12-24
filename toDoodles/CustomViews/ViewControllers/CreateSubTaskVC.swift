//
//  CreateSubTaskVC.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 14/12/2020.
//

import UIKit

protocol CreateSubTaskCellDelegate: AnyObject {
    func createSubTask(subTaskLabel: String) // chsnge this to a task?
}

class CreateSubTaskVC: CreateTaskVC {
    
    weak var subDelegate: CreateSubTaskCellDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    

    override func addTask() {
        guard let taskString = textField.text else { return }
        
        subDelegate?.createSubTask(subTaskLabel: taskString)
        dismiss(animated: true)
    }
    
    
    func configureVC() {
        titleLabel.text = "Create sub task"
    }
    
}
