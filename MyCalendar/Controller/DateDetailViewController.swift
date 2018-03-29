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
    var eventTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        setupRightBarButton()
        setupSubViews()
    }
    
    func setupRightBarButton() {
        let addBtn = UIButton(type: .custom)
        addBtn.setImage(UIImage(named:"icon_add"), for: .normal)
        addBtn.addTarget(self, action: #selector(addBtnOnClick), for: .touchUpInside)
        
        let rightBar = UIBarButtonItem(customView: addBtn)
        self.navigationItem.rightBarButtonItem = rightBar
    }
    
    @objc func addBtnOnClick() {
        
    }
    
    func setupSubViews() {
        headerView = DateHeaderView(frame: CGRect(x: 0, y: 0, width: Config.screenWidth, height: Config.screenWidth))
        if let date = self.date { headerView.setupInfo(date: date) }
        
        eventTableView = UITableView(frame: CGRect(x: 0, y: -64, width: Config.screenWidth, height: Config.screenHeight + 64))
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.showsVerticalScrollIndicator = false
        eventTableView.showsHorizontalScrollIndicator = false
        eventTableView.tableHeaderView = headerView
        eventTableView.separatorStyle = .none
        eventTableView.register(EventCell.self, forCellReuseIdentifier: EventCell.className)
        self.view.addSubview(eventTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DateDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.className) as! EventCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y >= (Config.screenWidth-128) {
            let result = ToolBox.getComponentsFromDate(date: self.date!)
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white,
                                                                            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 23)]
            self.navigationItem.title = "\(result.year)-\(result.month)-\(result.day)"
            let image = ToolBox.createImage(Config.getColor(red: 255, green: 90, blue: 90), CGSize(width: Config.screenWidth, height: 64))
            self.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics(rawValue: 0)!)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        } else {
            self.navigationItem.title = ""
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics(rawValue: 0)!)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
}
