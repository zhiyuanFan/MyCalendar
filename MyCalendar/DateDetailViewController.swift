//
//  DateDetailViewController.swift
//  MyCalendar
//
//  Created by Jason Fan on 27/03/2018.
//  Copyright © 2018 zyFan. All rights reserved.
//

import UIKit

class DateDetailViewController: UIViewController {

    var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setupSubViews()
    }
    
    func setupSubViews() {
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: Config.screenWidth, height: Config.screenWidth))
        headerView.backgroundColor = Config.getColor(red: 255, green: 90, blue: 90)
        self.view.addSubview(headerView)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
