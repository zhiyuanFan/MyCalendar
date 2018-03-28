//
//  WeekView.swift
//  MyCalendar
//
//  Created by Jason Fan on 08/03/2018.
//  Copyright © 2018 zyFan. All rights reserved.
//

import UIKit

class WeekView: UIView {

    var stackView: UIStackView!
    
    override init(frame: CGRect) {
        let rect = CGRect(origin: CGPoint.zero, size: CGSize(width: Config.screenWidth, height: 30))
        super.init(frame: rect)
        
        setupSubViews()
    }
    
    func setupSubViews() {
        stackView = UIStackView(frame: self.bounds)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        let labelSize = CGSize(width: Config.screenWidth / 7, height: 53)
        let weeks = Config.weekdays
        
        for i in 0..<7 {
            let label = UILabel()
            label.frame.size = labelSize
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.text = weeks[i]
            stackView.addArrangedSubview(label)
        }
        
        addSubview(stackView)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
