//
//  TodayVC.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 28/11/2020.
//

import UIKit

protocol passMainTaskDellegate {
    func passMainTask(task: Task)
}

class TodayVC: UIViewController {
    
    enum Section { case main }
    
    let addTaskButton           = TDroundButton(height: CGFloat(50))
    let containerView           = UIView()
    
    var tasks:                  [Task]?
    var allTasks:               [Task]?
    
    var collectionView:         UICollectionView!
    var dataSource:             UICollectionViewDiffableDataSource<Section, Task>!
    
// MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    
        configureCollectionView()
        configureDataSource()
        configureAddTaskButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchTasks()
    }

    
// MARK: - @objc Functions
    
    @objc func pushCreateTaskVC() {
        let createTaskVC            = CreateMainTaskVC()
        createTaskVC.mainDelegate   = self
        present(createTaskVC, animated: true)
    }
    
// MARK: - Private Functions
    
    
    func fetchTasks() {
        DataControllerManager.shared.fetchTasks(completed: { [weak self] result in
            guard let self = self else { return }
            switch result{
            
            case .success(let tasks):
                self.allTasks = tasks
                self.tasks = tasks.filter { $0.completion == .pending }
                if self.tasks?.count == 0 {
                    configureContainerViewFromMainThread()
                    return
                }
                
                updateData(on: self.tasks!)
                self.containerView.removeFromSuperview()
                
            case .failure(_):
                DispatchQueue.main.async {
                    self.configureContainerViewFromMainThread()
                }
            }
        })
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Task>(collectionView: collectionView, cellProvider: { collectionView, indexPath, task -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TDTaskCell.reuseID, for: indexPath) as! TDTaskCell
            guard let tasks = self.tasks else { return UICollectionViewCell() }
            
            cell.set(task: tasks[indexPath.row], currentIndex: indexPath.row)
            cell.isUserInteractionEnabled = true
            cell.subCelldelegate = self

            return cell
        })
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <BadgeSupplementaryView>(elementKind: BadgeSupplementaryView.reuseIdentifier) { badgeView, string, indexPath in
            guard let task = self.dataSource.itemIdentifier(for: indexPath) else { return }
            
            let hasBadgeCount = task.subTask?.count ?? 0 > 0
            // Set the badge count as its label (and hide the view if the badge count is zero).
            badgeView.label.text = "\(task.subTask?.count ?? 0)"
            badgeView.isHidden = !hasBadgeCount
        }
    
        dataSource.supplementaryViewProvider = { view, kind, index in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: index)
        }
        
    }
    
    
    func updateData(on tasks: [Task]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Task>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tasks)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
            self.collectionView.reloadData()
        }
    }
    
    
    func changeCompletion(indexPath: IndexPath) {
        
        guard let tasks = tasks else { return }
        
        if tasks[indexPath.row].completion == .pending {
            tasks[indexPath.row].completion = .completed
        } else { tasks[indexPath.row].completion = .pending }
        
        DataControllerManager.shared.saveTasks()
        collectionView.reloadData()
        manageLocalNotifications(totalTasks: tasks.count, completedTasks: allTasks!.count)
    }
    
// MARK: - Layout configurations
    
    func configureCollectionView() {
        collectionView                   = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.configureCollectionViewCompositionalLayout())
        collectionView.backgroundColor   = .clear
        collectionView.delegate          = self
        collectionView.register(TDTaskCell.self, forCellWithReuseIdentifier: TDTaskCell.reuseID)
        
        view.addSubview(collectionView)
    }
    
    
    func configureAddTaskButton() {
        view.addSubview(addTaskButton)
        addTaskButton.addTarget(self, action: #selector(pushCreateTaskVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addTaskButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addTaskButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    
    func configureContainerViewFromMainThread() {
        DispatchQueue.main.async {
            self.view.addSubview(self.containerView)
            self.containerView.frame = self.view.bounds
            self.showEmptyStateView(with: Constants.Strings.Message.noTasksForToday, in: self.containerView)
            self.view.bringSubviewToFront(self.addTaskButton)
        }
    }
    
}

// MARK: - Extensions

extension TodayVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        changeCompletion(indexPath: indexPath)
    }
}


extension TodayVC: CreateMainTaskCellDelegate {
    func createMainTask() {
        fetchTasks()
    }
}


extension TodayVC: TaskCellDelegate {
    
    func buttonIsPressed(currentIndex: Int) {
        guard let tasks = tasks else { return }
        let subTaskScreen = SubTaskScreen(mainTask: tasks[currentIndex])
        navigationController?.pushViewController(subTaskScreen, animated: true)
    }
}
