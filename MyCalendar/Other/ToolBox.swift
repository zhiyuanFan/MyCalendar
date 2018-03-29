//
//  ToolBox.swift
//  MyCalendar
//
//  Created by Jason Fan on 29/03/2018.
//  Copyright © 2018 zyFan. All rights reserved.
//

import UIKit

class ToolBox: NSObject {
    class func createImage(_ color: UIColor, _ size: CGSize) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    
    class func getComponentsFromDate(date: Date) -> (year: Int, month: Int, day: Int, weekday: Int) {
        let components = Calendar.autoupdatingCurrent.dateComponents([.weekday, .day, .year, .month], from: date)
        guard let weekday = components.weekday else { fatalError("components.weekday no value") }
        guard let day = components.day else { fatalError("components.day no value") }
        guard let year = components.year else { fatalError("components.year no value") }
        guard let month = components.month else { fatalError("components.month no value")  }
        return (year, month, day, weekday)
    }
}
