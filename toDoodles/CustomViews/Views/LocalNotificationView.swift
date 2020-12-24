//
//  LocalNotificationView.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 17/12/2020.
//

import UIKit

class LocalNotificationView: UIView {

    let label = TDBodyLabel()
    let image = UIImageView(image: UIImage(systemName: "arrow.uturn.backward"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        // TODO: Fix this
        translatesAutoresizingMaskIntoConstraints = false
        isHidden                    = true
        isUserInteractionEnabled    = true
        backgroundColor             = .systemGray2
        layer.cornerRadius          = 15
        
        
        addSubviews(views: label, image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .secondaryLabel
        label.text      = "Undo"
        label.textColor = .secondaryLabel
        
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 30),
            widthAnchor.constraint(equalToConstant: 100),
            
            image.topAnchor.constraint(equalTo: topAnchor,  constant: 5),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),
            
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: image.leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
