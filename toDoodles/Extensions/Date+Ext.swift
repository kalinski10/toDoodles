//
//  Date+Ext.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 18/12/2020.
//

import Foundation


extension Date {
    func convertToDayMonthYearFormat() -> String {
        let dateFormatter       = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
}
