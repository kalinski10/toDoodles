//
//  TDAlertVC.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 17/12/2020.
//

import UIKit

class TDAlertVC: UIViewController {

    let containerView       = TDAlertContainerView()
    let alertTitle          = TDTitleLabel(titleColor: .label)
    let bodyLabel           = TDBodyLabel()
    let button              = TDButton(title: "Ok")
    
    let padding: CGFloat    = 20
    
    var titleText:          String?
    var bodyText:           String?

// MARK: - overrides

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubview(containerView)
        containerView.addSubviews(views: alertTitle, bodyLabel, button)
        
        configureLayout()
        configureComponents()
    }
    
    
    init(title: String, body: String) {
        super.init(nibName: nil, bundle: nil)
        titleText = title
        bodyText  = body
    }
    
// MARK: - @bjc functions
    
    @objc func buttonTapped() {
        dismiss(animated: true)
    }
    
// MARK: - private functions

    func configureComponents() {
        alertTitle.text = titleText
        alertTitle.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        bodyLabel.text  = bodyText
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    // MARK: - Layout configuretaions
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 220),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            alertTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            alertTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            alertTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            alertTitle.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.15),
            
            button.leadingAnchor.constraint(equalTo: alertTitle.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: alertTitle.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: 44),

            bodyLabel.topAnchor.constraint(equalTo: alertTitle.bottomAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: alertTitle.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: alertTitle.trailingAnchor),
            bodyLabel.bottomAnchor.constraint(equalTo: button.topAnchor)
        ])
    }
}
