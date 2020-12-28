//
//  SubTaskScreen.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 14/12/2020.
//

import UIKit

class SubTaskScreen: TDDeletionNotificationViewController {
    
    let tableView                       = UITableView(frame: .zero, style: .insetGrouped)
    let containerViewforEmptyState      = UIView()
    let barButtonItemOne                = UIBarButtonItem()
    let backBarButtonItem               = UIBarButtonItem()
    
    var filteredTasks:                  [SubTask] = []
    var mainTask:                       Task!

    var isTasksMorethanThree:           Bool { return filteredTasks.count >= 3 }
    
    // MARK: - Overrides and inits
    
    init(mainTask: Task) {
        super.init(nibName: nil, bundle: nil)
        self.mainTask = mainTask
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = mainTask.createdAt?.convertToDayMonthYearFormat()
        
        configureBarButtonItems()
        configureTableView()
        configureContainerView()
        fetchTasks()
    }
    
    override func retrieveDeletedTask() {
        let subtask         = SubTask(context: DataControllerManager.shared.context)
        subtask.body        = deletedTaskBody
        subtask.completion  = deletedTaskCompletion

        mainTask.addToSubTask(subtask)
        DataControllerManager.shared.saveTasks()
        fetchTasks()

        hideNotificationOnMainThread()
    }
    
    // MARK: - @objc Functions
    
    @objc func addNewSubtask() {
        guard isTasksMorethanThree else {
            let createSubTaskVC         = CreateSubTaskVC()
            createSubTaskVC.subDelegate = self
            present(createSubTaskVC, animated: true)
            return
        }
        presentTDAlerVCOnMainThread(title: Constants.Strings.Title.oops, body: Constants.Strings.Message.maxSubTasks)
    }
    
    
    @objc func dismissVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private functions
    
    func fetchTasks() {
        DataControllerManager.shared.fetchSubTasks(mainTask: self.mainTask) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let tasks):
                filteredTasks = tasks
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.containerViewforEmptyState.removeFromSuperview()
                }
                
            case .failure(_):
                DispatchQueue.main.async {
                    self.showEmptyStateView(with: Constants.Strings.Message.addSubTasks, in: self.containerViewforEmptyState)
                }
            }
        }
    }
    
    
    func changeCompletion(index: Int) {
        
        if filteredTasks[index].completion == .pending {
            filteredTasks[index].completion = .completed
        } else { filteredTasks[index].completion = .pending }
        
        DataControllerManager.shared.saveTasks()
        fetchTasks()
    }
    
    
    func taskCompletionCheck() {
        let tasks = filteredTasks.filter { $0.completion == .completed }
        if tasks.count == filteredTasks.count && filteredTasks.count != 0 {
            presentTDAlerVCOnMainThread(title: Constants.Strings.Title.congrats, body: Constants.Strings.Message.allTasksCompleted)
            mainTask.completion = .completed
            DataControllerManager.shared.saveTasks()
        }
    }

    
    // MARK: - Layout Configurations
    
    func configureBarButtonItems() {
        configureItemOne()
        ConfigureBackItem()
        
        navigationItem.leftBarButtonItem  = backBarButtonItem
        navigationItem.rightBarButtonItem = barButtonItemOne
    }
    
    // i could easily refactor these into another file
    func configureItemOne() {
        barButtonItemOne.image            = Constants.SystemImage.edit
        barButtonItemOne.tintColor        = .systemIndigo
        barButtonItemOne.style            = .plain
        barButtonItemOne.target           = self
        barButtonItemOne.action           = #selector(addNewSubtask)
    }
    
    
    func ConfigureBackItem() {
        backBarButtonItem.image           = Constants.SystemImage.chevronBackward
        backBarButtonItem.tintColor       = .systemIndigo
        backBarButtonItem.style           = .plain
        backBarButtonItem.target          = self
        backBarButtonItem.action          = #selector(dismissVC)
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame                   = view.bounds
        tableView.delegate                = self
        tableView.dataSource              = self
        tableView.rowHeight               = 80
        tableView.allowsSelection         = false
        tableView.register(SubTaskCell.self, forCellReuseIdentifier: SubTaskCell.reuseID)
    }
    
    
    func configureContainerView() {
        view.addSubview(containerViewforEmptyState)
        containerViewforEmptyState.frame = view.bounds
    }
    
}

// MARK: - Extensions

extension SubTaskScreen: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell                = tableView.dequeueReusableCell(withIdentifier: SubTaskCell.reuseID, for: indexPath) as! SubTaskCell
        cell.body.text          = filteredTasks[indexPath.row].body
        cell.subCellDelegate    = self
        cell.set(completion: filteredTasks[indexPath.row].completion, at: indexPath.row)
        cell.bringSubviewToFront(cell.button)
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action  = UIContextualAction(style: .destructive, title: Constants.Strings.Title.delete) { [weak self] action, view, completionHandler in
            guard let self = self else { return }
            
            let taskToRemove            = self.filteredTasks[indexPath.row]
            
            self.deletedTaskBody        = taskToRemove.body
            self.deletedTaskCompletion  = taskToRemove.completion
            
            self.presentNotificationOnMainThread()
            
            DataControllerManager.shared.context.delete(taskToRemove)
            DataControllerManager.shared.saveTasks()
            
            self.filteredTasks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.fetchTasks()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.Strings.Header.addThreeTasks
    }
     
}


extension SubTaskScreen: CreateSubTaskCellDelegate, SubTaskButtonPressedDelegate {
    
    func createSubTask(subTaskLabel: String) {
        
        // TODO: refactor this out
        let subtask         = SubTask(context: DataControllerManager.shared.context)
        subtask.body        = subTaskLabel
        subtask.completion  = .pending
        
        // adding to sub task
        mainTask.addToSubTask(subtask)
        DataControllerManager.shared.saveTasks()
        fetchTasks()
    }
    
    
    func completedButtonPressed(at index: Int) {
        changeCompletion(index: index)
        self.tableView.reloadData()
        taskCompletionCheck()
    }
    
}
