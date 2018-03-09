//
//  CustomeCell.swift
//  MyCalendar
//
//  Created by Jason Fan on 08/03/2018.
//  Copyright © 2018 zyFan. All rights reserved.
//

import Foundation
import JTAppleCalendar
import SnapKit

class CustomeCell : JTAppleCell {
    
    var selectedView: UIView!
    var dateLabel: UILabel!
    var eventView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubViews()
    }
    
    func setupSubViews() {

        selectedView = UIView()
        selectedView.isHidden = true
        selectedView.backgroundColor = Config.getColor(red: 255, green: 90, blue: 90)
        addSubview(selectedView)
        
        dateLabel = UILabel()
        addSubview(dateLabel)
        
        eventView = UIView()
        eventView.isHidden = true
        eventView.backgroundColor = Config.getColor(red: 130, green: 219, blue: 5)
        addSubview(eventView)
     
        setupLayout()
    }
    
    func setupLayout() {
        selectedView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        selectedView.layer.cornerRadius = 20
        
        dateLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        eventView.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.centerX.equalTo(dateLabel.snp.centerX)
            make.size.equalTo(CGSize(width: 6, height: 6))
        }
        eventView.layer.cornerRadius = 3.0
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
