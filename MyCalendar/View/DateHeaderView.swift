//
//  DateHeaderView.swift
//  MyCalendar
//
//  Created by Jason Fan on 27/03/2018.
//  Copyright © 2018 zyFan. All rights reserved.
//

import UIKit

class DateHeaderView: UIView {
    
    var weekLabel: UILabel!
    var weekJPLabel: UILabel!
    var dateLabel: UILabel!
    var dateJPLabel: UILabel!
    var tipLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Config.getColor(red: 255, green: 90, blue: 90)
        setupSubviews()
    }
    
    
    func setupSubviews() {
     
        weekLabel = UILabel()
        weekLabel.font = UIFont.systemFont(ofSize: 33)
        weekLabel.textColor = UIColor.white
        addSubview(weekLabel)
        
        weekJPLabel = UILabel()
        weekJPLabel.font = UIFont.systemFont(ofSize: 23)
        weekJPLabel.textColor = UIColor.white
        addSubview(weekJPLabel)
        
        dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 40)
        dateLabel.textColor = UIColor.white
        addSubview(dateLabel)
        
        dateJPLabel = UILabel()
        dateJPLabel.font = UIFont.systemFont(ofSize: 23)
        dateJPLabel.textColor = UIColor.white
        addSubview(dateJPLabel)
        
        tipLabel = UILabel()
        tipLabel.font = UIFont.systemFont(ofSize: 23)
        tipLabel.textColor = UIColor.white
        addSubview(tipLabel)

        setupLayout()
    }
    
    func setupLayout() {
        dateLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
        }
        
        weekJPLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(dateLabel.snp.top).offset(-30)
            make.centerX.equalTo(dateLabel.snp.centerX)
        }

        
        weekLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(weekJPLabel.snp.top).offset(-5)
            make.centerX.equalTo(dateLabel.snp.centerX)
        }
        
        dateJPLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.centerX.equalTo(dateLabel.snp.centerX)
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-20)
            make.centerX.equalTo(dateLabel.snp.centerX)
        }
    }
    
    func setupInfo(date: Date) {
        let components = Calendar.autoupdatingCurrent.dateComponents([.weekday, .day, .year, .month], from: date)
        guard let weekday = components.weekday else { return }
        guard let day = components.day else { return }
        guard let year = components.year else { return }
        guard let month = components.month else { return }
        dateLabel.text = "\(day)"
        dateJPLabel.text = Config.days[day - 1]
        weekLabel.text = Config.weekdayInfos[weekday - 1]
        weekJPLabel.text = Config.weekdaysTranslation[weekday - 1]
        tipLabel.text = "\(year) / \(month)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
