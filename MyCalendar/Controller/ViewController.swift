//
//  ViewController.swift
//  MyCalendar
//
//  Created by Jason Fan on 08/03/2018.
//  Copyright © 2018 zyFan. All rights reserved.
//

import UIKit
import JTAppleCalendar
import CoreData

class ViewController: UIViewController {
    let formatter = DateFormatter()
    var headView: UIView!
    var year: UILabel!
    var month: UILabel!
    var weekView: WeekView!
    var calendarView: JTAppleCalendarView!
    var eventsFromLocal: [String] = [String]()
    var currentMonth: String = ""
    var currentYear: String = ""
    
    //点击动画及返回界面 属性
    var selectedFrame: CGRect?
    var customInteractor: CustomInteractor?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(handleEventNotification), name: NSNotification.Name(rawValue: Config.handleEventNotification), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics(rawValue: 0)!)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.delegate = self
        
        setupBackButton()
        setupSubViews()
        calendarView.visibleDates { (visibleDates) in
            self.configViewsWithDate(visibleDates: visibleDates)
        }
        fetchEventsData()
    }
    
    func setupBackButton() {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named:"back"), for: .normal)
        
        let backBar = UIBarButtonItem(customView: backBtn)
        self.navigationItem.backBarButtonItem = backBar
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setupSubViews() {
        
        headView = UIView()
        headView.backgroundColor = Config.getColor(red: 255, green: 90, blue: 90)
        self.view.addSubview(headView)
        
        year = UILabel()
        year.textColor = UIColor.white
        year.font = UIFont.systemFont(ofSize: 30)
        headView.addSubview(year)
        
        month = UILabel()
        month.textColor = UIColor.white
        month.font = UIFont.systemFont(ofSize: 33)
        headView.addSubview(month)
        
        weekView = WeekView(frame: CGRect.zero)
        headView.addSubview(weekView)
        
        calendarView = JTAppleCalendarView()
        calendarView.register(CustomeCell.self, forCellWithReuseIdentifier: CustomeCell.className)
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        calendarView.backgroundColor = UIColor.white
        calendarView.scrollDirection = UICollectionViewScrollDirection.vertical
        calendarView.isPagingEnabled = true
        let calendarH = Config.screenHeight - 240
        let calendarW = Config.screenWidth
        calendarView.minimumLineSpacing = (calendarH - calendarW) / 6
        calendarView.minimumInteritemSpacing = 0
        calendarView.showsVerticalScrollIndicator = false
        calendarView.showsHorizontalScrollIndicator = false
        self.view.addSubview(calendarView)
        
        setupLayout()
    }
    
    func setupLayout() {
        
        headView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(240)
        }
        
        year.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.equalTo(10)
        }
        
        month.snp.makeConstraints { (make) in
            make.top.equalTo(year.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        weekView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(53)
        }
        
        calendarView.snp.makeConstraints { (make) in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }

    func configViewsWithDate(visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        formatter.dateFormat = "M"
        let monthNum = Int(formatter.string(from: date))!
        if currentMonth != formatter.string(from: date) && currentMonth != "" {
            cubeAnimate(targetLabel: month, info: Config.monthInfo(monthNum), isUpForward: isNextMonth(date: date))
        } else {
            month.text = Config.monthInfo(monthNum)
        }
        currentMonth = formatter.string(from: date)
        
        formatter.dateFormat = "yyyy"
        if currentYear == "" || currentYear != formatter.string(from: date) {
            year.text = formatter.string(from: date)
            currentYear = formatter.string(from: date)
        }
    }
    
    func isNextMonth(date: Date) -> Bool {
        formatter.dateFormat = "yyyy"
        let newYear = formatter.string(from: date)
        formatter.dateFormat = "M"
        let newMonth = formatter.string(from: date)
        
        if currentYear == newYear {
            return Int(newMonth)! > Int(currentMonth)!
        } else {
            return Int(newYear)! > Int(currentYear)!
        }
    }
    
    func handleCellVisiable(cell: CustomeCell, cellState: CellState) {
        cell.isHidden = cellState.dateBelongsTo == .thisMonth ? false : true
    }
    
    func handleCellSelected(cell: CustomeCell, cellState: CellState) {
        cell.selectedView.isHidden = !cellState.isSelected
    }
    
    func handleCellTextColor(cell: CustomeCell, cellState: CellState) {
        if cellState.isSelected {
            cell.dateLabel.textColor = UIColor.white
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                cell.dateLabel.textColor = Config.getColor(red: 142, green: 142, blue: 142)
            } else {
                cell.dateLabel.textColor = Config.getColor(red: 225, green: 225, blue: 225)
            }
        }
    }
    
    func handleCellEvent(cell: CustomeCell, cellState: CellState) {
        cell.eventView.isHidden = !eventsFromLocal.contains(formatter.string(from: cellState.date))
    }
    
    func configCalendarCell(cell: JTAppleCell?, cellState: CellState) {
        formatter.dateFormat = "yyyy MM dd"
        guard let validCell = cell as? CustomeCell else { return }
        // handleCellVisiable(cell: validCell, cellState: cellState)
        handleCellSelected(cell: validCell, cellState: cellState)
        handleCellTextColor(cell: validCell, cellState: cellState)
        handleCellEvent(cell: validCell, cellState: cellState)
    }
    
    func fetchEventsData() {
        eventsFromLocal = DBHelper.fetchEventsDateSet()
    }
    
    @objc func handleEventNotification() {
        fetchEventsData()
        calendarView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {

    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")
        let endDate = formatter.date(from: "2018 12 31")
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        return parameters
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: CustomeCell.className, for: indexPath) as! CustomeCell
        cell.dateLabel.text = cellState.text
        configCalendarCell(cell: cell, cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configCalendarCell(cell: cell, cellState: cellState)
        let indexPath = calendar.indexPath(for: cell!)
        let attributeLayout: UICollectionViewLayoutAttributes = calendar.layoutAttributesForItem(at: indexPath!)!
        selectedFrame = calendar.convert(attributeLayout.frame, to: calendar.superview)
        let detailVC = DateDetailViewController()
        detailVC.date = date
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configCalendarCell(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        configViewsWithDate(visibleDates: visibleDates)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configCalendarCell(cell: cell, cellState: cellState)
    }
}

extension ViewController {

    func cubeAnimate(targetLabel: UILabel, info: String, isUpForward: Bool) {

        let labelCopy = UILabel(frame: targetLabel.frame)
        labelCopy.alpha = 0
        labelCopy.text = info
        labelCopy.font = targetLabel.font
        labelCopy.textAlignment = targetLabel.textAlignment
        labelCopy.textColor = targetLabel.textColor
        labelCopy.backgroundColor = UIColor.clear
        let labelH2 = targetLabel.frame.size.height / 2
        
        let copyTY = isUpForward ? labelH2 : -labelH2
        let targetTY = -copyTY
        
        labelCopy.transform = CGAffineTransform(scaleX: 1.0, y: 0.1).concatenating(CGAffineTransform(translationX: 1.0, y: copyTY))
        self.headView.addSubview(labelCopy)
        UIView.animate(withDuration: 0.5, animations: {

            targetLabel.transform =  CGAffineTransform(scaleX: 1.0, y: 0.1).concatenating(CGAffineTransform(translationX: 1.0, y: targetTY))
            targetLabel.alpha = 0
            labelCopy.alpha = 1
            labelCopy.transform = CGAffineTransform.identity
        }) { (isFinished) in
            // 当动画执行完毕后，将labelCopy的信息赋值给targetLabel，并还原targetLabel的状态，即与labelCopy相同的状态，然后移除labelCopy
            targetLabel.alpha = 1
            targetLabel.text = labelCopy.text
            targetLabel.transform = CGAffineTransform.identity
            labelCopy.removeFromSuperview()
        }
    }
    
    
}

