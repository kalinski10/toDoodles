//
//  TDTextField.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 30/11/2020.
//

import UIKit

class TDTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor             = .clear
        
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        minimumFontSize             = 12
        adjustsFontSizeToFitWidth   = true
        
        textAlignment               = .left
        placeholder                 = "Start writing your task here!"

        returnKeyType               = .go
    }
    
}
