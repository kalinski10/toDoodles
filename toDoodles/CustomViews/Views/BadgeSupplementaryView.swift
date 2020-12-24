//
//  BadgeSupplementaryView.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 19/12/2020.
//

import UIKit

class BadgeSupplementaryView: UICollectionReusableView {

    static let reuseIdentifier = "badge-reuse-identifier"
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    override var frame: CGRect {
        didSet {
            configureBorder()
        }
    }
    override var bounds: CGRect {
        didSet {
            configureBorder()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}

extension BadgeSupplementaryView {
    
    func configure() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory         = true
        label.font          = UIFont.preferredFont(forTextStyle: .caption1)
        label.textAlignment = .center
        label.textColor     = .label
        
        backgroundColor     = .systemIndigo
        addSubview(label)
        configureBorder()
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
    func configureBorder() {
        let radius = bounds.width / 2.0
        layer.cornerRadius = radius
    }
}
