//
//  TDMinusBar.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 30/11/2020.
//

import UIKit

class TDMinusBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        backgroundColor     = .systemGray
        layer.cornerRadius  = 4
        
        translatesAutoresizingMaskIntoConstraints            = false
        heightAnchor.constraint(equalToConstant: 8).isActive = true
        widthAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
}
