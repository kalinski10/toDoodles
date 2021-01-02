//
//  CreateTaskVC.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 29/11/2020.
//

import UIKit


class CreateTaskVC: UIViewController {
    
    var containerView       = UIView()
    var minusView           = TDMinusBar()
    var titleLabel          = TDTitleLabel(titleColor: .label)
    var taskContainer       = UIView()
    var textField           = TDTextField()
    var createButton        = TDButton(title: Constants.Strings.ButtonText.addTask)
    
    var isKeyboardPresent   = false
    
  
    let padding: CGFloat    = 18
    let context             = DataControllerManager.shared.context
    
// MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(containerView)
        containerView.addSubviews(views: minusView, titleLabel, taskContainer, textField, createButton)
        configure()
    }

    
    func configure() {
        configureContainer()
        configureTaskContainer()
        configureTextView()
        configureCreateButton()
        registerForNotifictions()
        configureUILayout()
    }
    
// MARK: - Local Notifications 
    
    func registerForNotifictions() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillshow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
// MARK: - @objc Functions
    
    @objc func addTask() {}

    
    @objc func keyboardWillshow(notification: NSNotification) {
        let keyboardframe = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        if isKeyboardPresent { return }
        self.view.frame.origin.y -= keyboardframe.height - padding
        isKeyboardPresent = true
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification){
        self.view.frame.origin.y    = 0
        isKeyboardPresent           = false
    }

// MARK: - Private functions
    
    func createNewTask(taskString: String) {
        // this is how we create new task and then add properties
        let newTask             = Task(context: self.context)
        newTask.taskDescription = taskString
        newTask.completion      = .pending
        newTask.createdAt       = Date()
    }
    

    func saveTask() {
        do { try self.context.save() }
        catch { print(TDError.savingError.rawValue) }
    }
    
// MARK: - UI Configurations
    
    func configureContainer() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor       = .systemBackground
        containerView.layer.cornerRadius    = 15
    }
    

    func configureTaskContainer() {
        taskContainer.translatesAutoresizingMaskIntoConstraints = false
        taskContainer.backgroundColor       = .systemGray5
        taskContainer.layer.cornerRadius    = 15
    }
    
    
    func configureTextView() {
        textField.delegate = self
    }
    
    
    func configureCreateButton() {
        createButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
    }

// MARK: - Layout UI
    
    func configureUILayout() {
        NSLayoutConstraint.activate([
            
            // container view layout
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // minus view layout
            minusView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            minusView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            // title label layout
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            // task container layout
            taskContainer.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.4),
            taskContainer.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -padding * 2),
            taskContainer.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            taskContainer.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -padding),
            
            // text field layout
            textField.topAnchor.constraint(equalTo: taskContainer.topAnchor, constant: padding),
            textField.bottomAnchor.constraint(equalTo: taskContainer.bottomAnchor, constant: -padding),
            textField.leadingAnchor.constraint(equalTo: taskContainer.leadingAnchor, constant: padding),
            textField.trailingAnchor.constraint(equalTo: taskContainer.trailingAnchor, constant: -padding),
            
            // create button layout
            createButton.heightAnchor.constraint(equalToConstant: 50),
            createButton.widthAnchor.constraint(equalTo: taskContainer.widthAnchor),
            createButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding * 2),
            createButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            
        ])
    }
}

// MARK: - Extensions

extension CreateTaskVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addTask()
        return true
    }
}
