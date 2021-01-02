//
//  HistoryVC.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 28/11/2020.
//

import UIKit

class HistoryVC: TDDeletionNotificationViewController {
    
    let containerView           = UIView()
    var completedTasks: [Task]  = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, Task>!

// MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        updateListView()
    }

    
    override func retrieveDeletedTask() {
        let task                = Task(context: DataControllerManager.shared.context)
        task.taskDescription    = deletedTaskBody!
        task.completion         = deletedTaskCompletion
        task.createdAt          = deletedTaskCreatedAt
        
        DataControllerManager.shared.saveTasks()
        updateListView()
        
        hideNotificationOnMainThread()
    }
    
// MARK: - Private functions
    
    func updateData(with tasks: [Task]) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, Task>()
        snapShot.appendSections([1])
        snapShot.appendItems(tasks)
        DispatchQueue.main.async { self.dataSource.apply(snapShot) }
    }
    
    
    func updateListView() {
        DataControllerManager.shared.fetchTasks{ [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let tasks):
                self.completedTasks = self.getCorrespondingTasks(with: tasks)
                    self.updateData(with: self.completedTasks)
                if completedTasks.count == 0 {
                    self.configureEmptyStateViewOnMainThread()
                    return
                }
                self.containerView.removeFromSuperview()
                
            case .failure(_):
                configureEmptyStateViewOnMainThread()
                self.completedTasks = []
                self.updateData(with: completedTasks)
            }
        }
    }

// MARK: - Layout Configurations
    
    func configureCollectionListCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.trailingSwipeActionsConfigurationProvider = { [weak self] indexpath in
            guard let self = self else { return nil }
            return self.configureTrailingSwipeAction(indexPath: indexpath)
        }
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    
    func configureTrailingSwipeAction(indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: Constants.Strings.Title.delete) { [weak self] action, view, completionHandler in
            guard let self = self else { return }
            
            let taskToRemove            = self.completedTasks[indexPath.row]
            
            self.deletedTaskBody        = taskToRemove.taskDescription
            self.deletedTaskCompletion  = taskToRemove.completion
            self.deletedTaskCreatedAt   = taskToRemove.createdAt
            
            self.presentNotificationOnMainThread()
            
            DataControllerManager.shared.context.delete(taskToRemove)
            DataControllerManager.shared.saveTasks()
            
            self.completedTasks.remove(at: indexPath.row)
            
            self.updateListView()
        }
        
        let incompleteAction = UIContextualAction(style: .normal, title: Constants.Strings.Title.moveToIncomplete) { [weak self] action, view, completionHandler in
            guard let self   = self else { return }
            
            let task         = self.completedTasks[indexPath.row]
            task.completion  = .pending
            
            DataControllerManager.shared.saveTasks()
            
            self.updateListView()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, incompleteAction])
    }
    
    
    func configureEmptyStateViewOnMainThread() {
        DispatchQueue.main.async {
            self.containerView.frame = self.view.bounds
            self.view.addSubview(self.containerView)
            self.showEmptyStateView(with: Constants.Strings.Message.noCompletedTasks, in: self.containerView)
        }
    }
    
    
    func configureCollectionView() {
        collectionView      = UICollectionView(frame: view.bounds, collectionViewLayout: configureCollectionListCompositionalLayout())
        collectionView.allowsSelection = false
        view.addSubviews(views: collectionView)
        
        let reg = UICollectionView.CellRegistration<UICollectionViewListCell, Task> {
            cell, indexPath, task in
            
            var content                 = UIListContentConfiguration.valueCell()
            content.text                = task.taskDescription
            cell.contentConfiguration   = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Task>(collectionView: collectionView, cellProvider: { collectionView, indexPath, task in
            collectionView.dequeueConfiguredReusableCell(using: reg, for: indexPath, item: task)
        })
    }
    
    
}
