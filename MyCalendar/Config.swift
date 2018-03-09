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
}
