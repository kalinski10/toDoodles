//
//  SubTaskCell.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 14/12/2020.
//

import UIKit

protocol SubTaskButtonPressedDelegate: AnyObject {
    func completedButtonPressed(at index: Int)
}

class SubTaskCell: UITableViewCell {

    static let reuseID = "subTaskCellID"
    
    let body    = UILabel()
    let button  = UIButton()
    
    var taskcellIndex: Int!
    var subCellDelegate: SubTaskButtonPressedDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureButton()
        configureBody()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func checkMarkButton(_ sender: UIButton) {
        subCellDelegate?.completedButtonPressed(at: taskcellIndex)
    }
    
    
    func configureBody() {
        addSubview(body)
        body.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            body.topAnchor.constraint(equalTo: topAnchor),
            body.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            body.trailingAnchor.constraint(equalTo: button.leadingAnchor),
            body.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    func set(completion: Completed, at index: Int) {
        taskcellIndex = index
        
        switch completion {
        case .completed:
            button.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .normal)
        case .pending:
            button.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    
    func configureButton() {
        addSubview(button)

        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = .systemIndigo
        
        isUserInteractionEnabled = true
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(checkMarkButton), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.widthAnchor.constraint(equalTo: button.heightAnchor)
        ])
    }
    
    
}
