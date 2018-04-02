//
//  DateDetailViewController.swift
//  MyCalendar
//
//  Created by Jason Fan on 27/03/2018.
//  Copyright © 2018 zyFan. All rights reserved.
//

import UIKit
import CoreData

class DateDetailViewController: UIViewController {

    var headerView: DateHeaderView!
    var date: Date?
    var eventTableView: UITableView!
    var dataArray: [Events]?
    var lineView: UIView!
    var blankView: BlankView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        setupRightBarButton()
        setupSubViews()
        if let date = self.date {
            fetchEvents(date: date)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lineView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lineView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lineView.isHidden = false
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
        eventTableView.backgroundColor = UIColor.clear
        eventTableView.bounces = false
        eventTableView.register(EventCell.self, forCellReuseIdentifier: EventCell.className)
        self.view.addSubview(eventTableView)
        
        lineView = UIView(frame: CGRect(x: 35, y: 0, width: 1, height: eventTableView.contentSize.height))
        lineView.backgroundColor = Config.getColor(red: 130, green: 219, blue: 5)
        self.view.insertSubview(lineView, belowSubview: eventTableView)
        
        blankView = BlankView(frame: CGRect(x: 0, y: Config.screenWidth, width: Config.screenWidth, height: Config.screenHeight - Config.screenWidth))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DateDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.className) as! EventCell
        let event = self.dataArray?[indexPath.row]
        cell.contentLabel.text = event?.content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (Config.screenWidth-128) {
            if self.navigationItem.title != "" { return }
            let result = ToolBox.getComponentsFromDate(date: self.date!)
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white,
                                                                            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 23)]
            self.navigationItem.title = "\(result.year)-\(result.month)-\(result.day)"
            let image = ToolBox.createImage(Config.getColor(red: 255, green: 90, blue: 90), CGSize(width: Config.screenWidth, height: 64))
            self.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics(rawValue: 0)!)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        } else {
            if self.navigationItem.title == "" { return }
            self.navigationItem.title = ""
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics(rawValue: 0)!)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
}

//Event Data
extension DateDetailViewController {
    func fetchEvents(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let dateStr = formatter.string(from: date)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Events")
        request.predicate = NSPredicate(format: "create_time == %@", dateStr)
        do {
            let array = try DBHelper.shared.manageObjectContext.fetch(request) as! [Events]
            if array.count != 0 {
                self.dataArray = [Events]()
                self.dataArray = array
                DispatchQueue.main.async {
                    self.eventTableView.reloadData()
                    self.lineView.frame = CGRect(x: 35, y: 0, width: 1, height: self.eventTableView.contentSize.height)
                }
            } else {
                eventTableView.addSubview(blankView)
            }
        } catch let error as NSError {
            print("DateDetailViewController fetch error : \(error)")
        }
    }
}
