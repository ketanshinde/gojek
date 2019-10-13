//
//  UIFont+CustomFont.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func customFont(font: FontName, size: CGFloat) -> UIFont {
        return UIFont(name:FontNameToString(customFont: font), size: size)!
    }
    
    class func customRegularFont(size: CGFloat) -> UIFont {
        return UIFont(name:FontNameToString(customFont: .FontNameRegular), size: size)!
    }
    
    class func customSemiBoldFont(size: CGFloat) -> UIFont {
        return UIFont(name:FontNameToString(customFont: .FontNameSemiBold), size: size)!
    }
        
    class func customBoldFont(size: CGFloat) -> UIFont {
        return UIFont(name:FontNameToString(customFont: .FontNameBold), size: size)!
    }
    
}
