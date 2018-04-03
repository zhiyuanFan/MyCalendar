//
//  Config.swift
//  MyCalendar
//
//  Created by Jason Fan on 08/03/2018.
//  Copyright © 2018 zyFan. All rights reserved.
//

import UIKit

class Config {
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    class func getColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    static var days: [String] {
        return ["ついたち","ふつか","みっか","よっか","いつか","むいか","なのか","ようか","ここのか","とおか","じゅういちにち","じゅうににち","じゅうさんにち","じゅうよにち","じゅうごにち","じゅうろくにち","じゅうしちにち","じゅうはちにち","じゅうくにち","はつか","にじゅういちにち","にじゅうににち","にじゅうさんにち","にじゅうよにち","にじゅうよにち","にじゅうろくにち","にじゅうななにち","にじゅうはちにち","にじゅうくにち","さんじゅうにち","さんじゅういちにち"]
    }
    
    static var weekdays: [String] {
        return ["日", "月", "火", "水", "木", "金", "土"]
    }
    
    static var weekdayInfos: [String] {
        return ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]
    }
    
    static var weekdaysTranslation: [String] {
        return ["にちようび", "げつようび", "かようび", "すいようび", "もくようび", "きんようび", "どようび"]
    }
    
    static var months: [String] {
        return ["いち", "に", "さん", "し", "ご", "ろく", "しち", "はち", "く", "じゅう", "じゅういち", "じゅうに"]
    }
    
    class func monthInfo(_ index: Int) -> String {
        return "\(index) 月 (\(months[index - 1])がつ)"
    }
    
    static var handleEventNotification: String {
        return "handleEventNotification"
    }
}
