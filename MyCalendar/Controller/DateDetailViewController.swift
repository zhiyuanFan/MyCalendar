//
//  DateDetailViewController.swift
//  MyCalendar
//
//  Created by Jason Fan on 27/03/2018.
//  Copyright © 2018 zyFan. All rights reserved.
//

import UIKit

class DateDetailViewController: UIViewController {

    var headerView: DateHeaderView!
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setupSubViews()
    }
    
    func setupSubViews() {
        headerView = DateHeaderView(frame: CGRect(x: 0, y: 0, width: Config.screenWidth, height: Config.screenWidth))
        if let date = self.date { headerView.setupInfo(date: date) }
        self.view.addSubview(headerView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
