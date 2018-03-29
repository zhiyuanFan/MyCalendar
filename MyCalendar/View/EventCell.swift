//
//  EventCell.swift
//  MyCalendar
//
//  Created by Jason Fan on 28/03/2018.
//  Copyright © 2018 zyFan. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    static var className: String = "EventCell"
    
    var lineView: UIView!
    var cycleView: UIImageView!
    var contentLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
//        self.layer.shouldRasterize = true
        self.selectionStyle = .none
        setupSubViews()
    }
    
    func setupSubViews() {
        lineView = UIView()
        lineView.backgroundColor = Config.getColor(red: 130, green: 219, blue: 5)
        addSubview(lineView)
        
        cycleView = UIImageView()
        cycleView.image = UIImage(named: "circle")
        addSubview(cycleView)
        
        contentLabel = UILabel()
        contentLabel.text = "this is a content label"
        contentLabel.textColor = UIColor.lightGray
        addSubview(contentLabel)
        
        setupLayout()
    }
    
    func setupLayout() {
        cycleView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(30)
            make.size.equalTo(CGSize(width: 10, height: 10))
        }
        
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(5)
            make.centerX.equalTo(cycleView.snp.centerX)
            make.width.equalTo(1)
            make.bottom.equalTo(-5)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineView.snp.right).offset(20)
            make.right.equalTo(-20)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    override var frame: CGRect {
        didSet {
            var rect = frame
            rect.origin.y += 10
            rect.size.height -= 10
            super.frame = rect
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
