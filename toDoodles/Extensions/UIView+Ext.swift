//
//  UIView+Ext.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 12/12/2020.
//

import UIKit

extension UIView {
    
    func addSubviews(views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
