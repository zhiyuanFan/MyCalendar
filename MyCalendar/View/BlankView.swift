//
//  BlankView.swift
//  MyCalendar
//
//  Created by Jason Fan on 02/04/2018.
//  Copyright © 2018 zyFan. All rights reserved.
//

import UIKit

class BlankView: UIView {
    
    var imageView: UIImageView!
    var tipLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubViews()
    }
    
    func setupSubViews() {
        
        imageView = UIImageView()
        imageView.image = UIImage(named: "moon")
        addSubview(imageView)
        
        tipLabel = UILabel()
        tipLabel.text = "何か入力してください"
        tipLabel.font = UIFont.systemFont(ofSize: 18)
        tipLabel.textColor = UIColor.lightGray
        addSubview(tipLabel)
        
        setupLayout()
    }
    
    func setupLayout() {
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-40)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }

        tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
