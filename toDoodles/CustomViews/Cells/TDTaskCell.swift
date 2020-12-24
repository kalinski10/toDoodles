//
//  TDTaskCell.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 28/11/2020.
//

import UIKit

protocol TaskCellDelegate: AnyObject {
    func buttonIsPressed(currentIndex: Int)
}


class TDTaskCell: UICollectionViewCell {
    
    static let reuseID          = "taskCellID"

    let taskDescription         = UILabel()
    let accessoryTypeButton     = UIButton()
    
    var currentIndex:           Int?
    
    var subCelldelegate:        TaskCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTaskDescription()
        configureButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func actionButtonTapped() {
        subCelldelegate?.buttonIsPressed(currentIndex: currentIndex!)
    }
    
    
    func set(task: Task, currentIndex: Int) {
        taskDescription.text = task.taskDescription
        self.currentIndex = currentIndex
        
        switch task.completion {
        case .pending:
            backgroundColor = .systemGray6
            
        case .completed:
            backgroundColor = .systemGreen
        }
    }

    // could refactor
    func configureButton() {
        addSubview(accessoryTypeButton)
        
        accessoryTypeButton.setImage(UIImage(systemName: "chevron.forward.square.fill"), for: .normal)
        accessoryTypeButton.tintColor = .systemIndigo
        accessoryTypeButton.translatesAutoresizingMaskIntoConstraints = false
        accessoryTypeButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            accessoryTypeButton.topAnchor.constraint(equalTo: topAnchor),
            accessoryTypeButton.leadingAnchor.constraint(equalTo: taskDescription.trailingAnchor),
            accessoryTypeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            accessoryTypeButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // could refactor
    private func configureTaskDescription() {
        layer.cornerRadius      = 15
        addSubview(taskDescription)
        
        taskDescription.translatesAutoresizingMaskIntoConstraints = false
        taskDescription.textAlignment               = .left
        taskDescription.font                        = UIFont.systemFont(ofSize: 16, weight: .semibold)
        taskDescription.adjustsFontSizeToFitWidth   = true
        taskDescription.numberOfLines               = 2
        taskDescription.textColor                   = .label
        
        NSLayoutConstraint.activate([
            taskDescription.heightAnchor.constraint(equalTo: heightAnchor),
            taskDescription.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            taskDescription.centerYAnchor.constraint(equalTo: centerYAnchor),
            taskDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
}
