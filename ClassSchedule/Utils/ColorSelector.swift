//
//  ColorSelector.swift
//  ClassSchedule
//
//  Created by wyx on 2017/11/11.
//  Copyright © 2017年 wyx. All rights reserved.
//

import Foundation
import UIKit

class ColorSelector {
    static func getColorFromTag(tag: Int) -> UIColor {
        switch tag {
        case 100:
            return UIColor(hexString: "FFDDDD")
        case 101:
            return UIColor(hexString: "FFEEDD")
        case 102:
            return UIColor(hexString: "FFFFDD")
        case 103:
            return UIColor(hexString: "DDFFDD")
        case 104:
            return UIColor(hexString: "DDDDFF")
        case 105:
            return UIColor(hexString: "EEDDFF")
        default:
            return UIColor.white
        }
    }
}
