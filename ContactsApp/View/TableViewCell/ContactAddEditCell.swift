//
//  ContactDetailsCell.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import UIKit
import SDWebImage

class ContactAddEditCell: UITableViewCell {
    
    @IBOutlet private weak var lblTitleHeader: UILabel!
    @IBOutlet weak var txtFieldDetails: UITextField!
    @IBOutlet private weak var viewBottomLine: UIView!
    
    var firstText: ((_ firstName: String)->())?
    var lastText: ((_ lastName: String)->())?
    var mobileText: ((_ mobileNumber: String)->())?
    var emailText: ((_ email: String)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBottomLine.backgroundColor = UIColor.lineSeperatorColor()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    func loadOtherData(item: OtherDetail) {
        
      //  lblTitleHeader.setLineSpacing(lineSpacing: 1.2)
        lblTitleHeader.applyAttributes(item.title, font: UIFont.customRegularFont(size: 16.0), textColor: UIColor.darkTextColor().withAlphaComponent(0.5), kerning: -0.5, alignment: .right)
        
       // txtFieldDetails.setLineSpacing(lineSpacing: 1.2)
        txtFieldDetails.applyAttributes(item.description, font: UIFont.customRegularFont(size: 16.0), textColor: UIColor.darkTextColor(), kerning: -0.5, alignment: .left)
        
        switch tag {
        case 0:
            txtFieldDetails.keyboardType = .alphabet
            txtFieldDetails.becomeFirstResponder()
        case 1:
            txtFieldDetails.keyboardType = .alphabet
        case 2:
            txtFieldDetails.keyboardType = .numberPad
        case 3:
            txtFieldDetails.keyboardType = .emailAddress
        default:
            break
        }
    }
}


extension ContactAddEditCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {}
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            
            switch tag {
            case 0:
                firstText?(updatedText)
            case 1:
                lastText?(updatedText)
            case 2:
                mobileText?(updatedText)
            case 3:
                emailText?(updatedText)
            default:
                break
            }
        }
        return true
    }
    
}
