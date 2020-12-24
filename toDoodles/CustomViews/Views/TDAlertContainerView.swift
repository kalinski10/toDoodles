//
//  TDAlertContainerView.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 17/12/2020.
//

import UIKit

class TDAlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContainer()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureContainer() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth  = 2
        layer.borderColor  = UIColor.white.cgColor
        layer.cornerRadius = 20
        backgroundColor    = .systemBackground
    }
   
}
