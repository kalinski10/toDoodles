//
//  TDDeletionNotificationViewController.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 24/12/2020.
//

import UIKit

class TDDeletionNotificationViewController: UIViewController {
    
    let taskDeletionNotificationView    = LocalNotificationView()

    var deletedTaskBody:                String?
    var deletedTaskCompletion:          Completed!
    var deletedTaskCreatedAt:           Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUndoNotification()
    }
    
    
    @objc func retrieveDeletedTask() {
        // creating deleted task

        // we are adding it back again
        
        // then we are saving it
        
        // fetching tasks again
        
        // hiding the notification

    }
    
    
    func hideNotificationOnMainThread() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.taskDeletionNotificationView.transform = .init(translationX: 0, y: 200)
            }, completion: {_ in
                self.taskDeletionNotificationView.isHidden  = true
                self.taskDeletionNotificationView.transform = .identity
            })
        }
    }
    
    
    func presentNotificationOnMainThread() {
        DispatchQueue.main.async {
            UIView.transition(with: self.taskDeletionNotificationView, duration: 0.5, options: .transitionFlipFromBottom, animations: { self.taskDeletionNotificationView.isHidden = false
                self.view.bringSubviewToFront(self.taskDeletionNotificationView)
            }, completion: nil)
        }
    }
    
    
    func configureUndoNotification() {
        view.addSubview(taskDeletionNotificationView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(retrieveDeletedTask))
        taskDeletionNotificationView.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            taskDeletionNotificationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskDeletionNotificationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }

    
}
