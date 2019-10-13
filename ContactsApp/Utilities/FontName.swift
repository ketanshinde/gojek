//
//  FontName.swift
//  ContactsApp
//
//  Created by Ketan on 04/10/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation

enum FontName : Int {
    
    case FontNameNone = 0
    case FontNameRegular
    case FontNameSemiBold
    case FontNameBold
}

func FontNameFromString(fontName: String) -> FontName {
    
    switch fontName {
    
    case "SFUIText-Regular":
        return .FontNameRegular
    
    case "SFUIText-Semibold":
        return .FontNameSemiBold
    
    case "SFUIText-Bold":
        return .FontNameBold
    
    default:
        return .FontNameNone
    }
}

func FontNameToString(customFont: FontName) -> String {
    
    switch customFont {
    
    case .FontNameRegular:
        return "SFUIText-Regular"
    
    case .FontNameSemiBold:
        return "SFUIText-Semibold"
    
    case .FontNameBold:
        return "SFUIText-Bold"
    
    default:
        return ""
    }
}
