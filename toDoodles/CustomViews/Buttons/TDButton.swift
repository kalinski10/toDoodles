//
//  TDActionButton.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 30/11/2020.
//

import UIKit

class TDButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        configure()
    }
    
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor     = .systemIndigo
        layer.cornerRadius  = 15
        setTitleColor(.white, for: .normal)
    }
    
}
