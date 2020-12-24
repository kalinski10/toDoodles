//
//  TDBodyLabel.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 17/12/2020.
//

import UIKit

class TDBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBodyLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBodyLabel() {
        textColor       = .secondaryLabel
        textAlignment   = .center
        numberOfLines   = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}
