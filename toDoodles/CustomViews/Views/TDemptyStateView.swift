//
//  TDemptyStateView.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 16/12/2020.
//

import UIKit

class TDemptyStateView: UIView {

    var title               = TDTitleLabel(titleColor: .systemGray2)
    let imageView           = UIImageView()
    let padding: CGFloat    = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureVIew()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message title: String) {
        self.init(frame: .zero)
        self.title.text     = title
    }
    
    
    func configureVIew() {
        addSubviews(views: title, imageView)
        backgroundColor     = .systemBackground
        
        
        imageView.image     = Constants.SystemImage.scribbleVariable
        imageView.tintColor = .systemGray2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            title.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            imageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 40),
            imageView.leadingAnchor.constraint(equalTo: title.leadingAnchor, constant: 40),
            imageView.widthAnchor.constraint(equalTo: title.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
    }
    
}
