//
//  TDButton.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 28/11/2020.
//

import UIKit

class TDroundButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(height: CGFloat) {
        self.init(frame: .zero)
        heightAnchor.constraint(equalToConstant: height).isActive = true
        layer.cornerRadius = height / 2
    }
    
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints              = false
        widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        setImage(UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        
        backgroundColor     = .systemIndigo
    }
    
}
