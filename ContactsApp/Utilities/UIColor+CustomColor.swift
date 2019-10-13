//
//  UIColor+CustomColor.swift
//  ContactsApp
//
//  Created by Ketan on 04/10/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func RGB2UIColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: (r) / 255.0, green: (g) / 255.0, blue: (b) / 255.0, alpha: 1.0)
    }
        
    class func darkTextColor() -> UIColor {
        return RGB2UIColor(r: 74, g: 74, b: 74) as UIColor
    }
    
    class func seaGreenColor() -> UIColor {
        return RGB2UIColor(r: 80, g: 227, b: 194) as UIColor
    }
    
    class func backgroundColor() -> UIColor {
        return RGB2UIColor(r: 249, g: 249, b: 249) as UIColor
    }
    
    class func lineSeperatorColor() -> UIColor {
        return RGB2UIColor(r: 240, g: 240, b: 240) as UIColor
    }
}
