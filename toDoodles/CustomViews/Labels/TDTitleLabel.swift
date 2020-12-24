//
//  TDTitleLabel.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 30/11/2020.
//

import UIKit

class TDTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(titleColor: UIColor) {
        self.init(frame: .zero)
        self.textColor = titleColor
    }
    
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment   = .center
        font            = UIFont.systemFont(ofSize: 30, weight: .semibold)
        numberOfLines   = 0
    }
    
}
