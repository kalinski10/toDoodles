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
    
}
