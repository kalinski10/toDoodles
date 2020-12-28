//
//  ProgressVC.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 28/11/2020.
//

import UIKit
import Charts

class ProgressVC: UIViewController {

    let emptyContainerView              = UIView()
    
    var pieChart                        = TDPieChartView()
    
    var pendingMainTasks: [Task]        = []
    var completedTasks: [Task]          = []
        
    var compDataEntry:                  PieChartDataEntry!
    var pendingDataEntry:               PieChartDataEntry!
        
    var numberOfTaskDataEntries         = [PieChartDataEntry]()

// MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configurePieChart()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTasks()
        setChartValues()
    }
    
// MARK: - Private functions
    
    func fetchTasks() {
        DataControllerManager.shared.fetchTasks{ [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let tasks):
                self.pendingMainTasks = tasks.filter { $0.completion == .pending }
                self.completedTasks   = tasks.filter { $0.completion == .completed}
                self.emptyContainerView.removeFromSuperview()
                
            case .failure(_):
                self.configureEmptyStateViewOnMainThread()
            }
        }
    }
    
    
    func setChartValues() {
        compDataEntry                   = PieChartDataEntry(value: Double(completedTasks.count), label: Constants.Strings.Label.completed)
        pendingDataEntry                = PieChartDataEntry(value: Double(pendingMainTasks.count), label: Constants.Strings.Label.pending)
        numberOfTaskDataEntries         = [compDataEntry, pendingDataEntry]
        updateChartData()
    }
        
        
    func updateChartData() {
        let chartDataSet                = PieChartDataSet(entries: numberOfTaskDataEntries, label: nil)
        let chartData                   = PieChartData(dataSet: chartDataSet)
        pieChart.data                   = chartData
            
        let colors                      = [UIColor.systemIndigo, UIColor.systemGray4]
        chartDataSet.colors             = colors
    }
    
// MARK: - Layout configureations
    
    func configureEmptyStateViewOnMainThread() {
        DispatchQueue.main.async {
            self.emptyContainerView.frame = self.view.bounds
            self.view.addSubview(self.emptyContainerView)
            self.showEmptyStateView(with: Constants.Strings.Message.noTasksForToday, in: self.emptyContainerView)
        }
    }
    
    
    func configurePieChart() {
        view.addSubviews(views: pieChart)
        pieChart.chartDescription?.text = Constants.Strings.Label.pieChartDescription
        
        NSLayoutConstraint.activate([
            pieChart.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pieChart.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pieChart.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pieChart.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
