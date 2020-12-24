//
//  TDPieChartView.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 22/12/2020.
//

import UIKit
import Charts

class TDPieChartView: PieChartView {


    override init(frame: CGRect) {
        super.init(frame: frame)
        configurations()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configurations() {
        translatesAutoresizingMaskIntoConstraints = false
        holeColor = .clear
    }

}
