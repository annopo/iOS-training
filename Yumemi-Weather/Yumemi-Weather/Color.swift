//
//  Color.swift
//  Yumemi-Weather
//
//  Created by anna.ishizaki on 2021/06/09.
//

import Foundation
import UIKit

extension UIColor{
    static func sunny()->UIColor {
        return UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1.0)
    }

    static func cloudy()->UIColor{
        return UIColor.lightGray
    }

    static func rainy()->UIColor{
        return UIColor(red: 65/255, green: 105/255, blue: 225/255, alpha: 1.0)
    }
}
