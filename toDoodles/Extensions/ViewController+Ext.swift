//
//  ViewController+Ext.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 16/12/2020.
//

import UIKit


extension UIViewController {
    
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = TDemptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    
    func presentTDAlerVCOnMainThread(title: String, body: String) {
        DispatchQueue.main.async {
            let alertVC = TDAlertVC(title: title, body: body)
            alertVC.modalPresentationStyle = .overCurrentContext
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func getCorrespondingTasks(with tasks: [Task]) -> [Task] {
        let filteredTask = tasks.filter { $0.completion == .completed }
        return filteredTask.sorted { $0.createdAt! > $1.createdAt! }
    }
    
    
    func scheduleLocalNotification(title: String?, body: String?) {
        
        // create identifier
        let identifier = "toDoodlesSummary"
        
        // access the current notification center
        let notificationCenter = UNUserNotificationCenter.current()
        
        // remove previously scheduled notifications
        notificationCenter.removeDeliveredNotifications(withIdentifiers: [identifier])
        
        if let newTitle = title, let newBody = body {
            
            // create content
            let content         = UNMutableNotificationContent()
            content.title       = newTitle
            content.body        = newBody
            content.sound       = UNNotificationSound.default
            
            // create trigger
            let trigger         = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            // Schedule notification
            let request         = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            notificationCenter.add(request, withCompletionHandler: nil)
        }
    }
    
    
    func manageLocalNotifications(totalTasks: Int, completedTasks: Int) {
        
        var title: String?
        var body: String?
        
        if totalTasks == 0 {
            title = "its lonely in here"
            body = "add some tasks"
        }
        
        else if completedTasks == 0 {
            title = "get started"
            body = "youve got \(totalTasks) tasks to go!"
        }
        
        else if completedTasks < totalTasks {
            title = "progress in action"
            body = "\(completedTasks) down \(totalTasks - completedTasks) to go!"
        }
        
        scheduleLocalNotification(title: title, body: body)
    }
    
    
}
