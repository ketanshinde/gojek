//
//  UILabel+Attribute.swift
//  ContactsApp
//
//  Created by Ketan on 04/10/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))


        // (Swift 4.1 and 4.0) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }
    
    func applyAttributes(_ title: String, font: UIFont, textColor: UIColor, kerning: CGFloat = 0.0,  alignment: NSTextAlignment = .left) {
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = alignment
        
        self.attributedText = NSAttributedString(
            string: title,
            attributes: [
                .font: font,
                .foregroundColor: textColor,
                .kern: kerning,
                .paragraphStyle: paraStyle
        ])
        
    }
}
