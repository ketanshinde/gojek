//
//  ContactDetailsCell.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import UIKit
import SDWebImage

class ContactDetailsCell: UITableViewCell {
    
    @IBOutlet private weak var lblTitleHeader: UILabel!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var viewBottomLine: UIView!
    
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
        
        lblTitleHeader.applyAttributes(item.title, font: UIFont.customRegularFont(size: 16.0), textColor: UIColor.darkTextColor().withAlphaComponent(0.5), kerning: -0.5, alignment: .right)
        lblTitleHeader.setLineSpacing(lineSpacing: 1.2)
      
        lblTitle.applyAttributes(item.description, font: UIFont.customRegularFont(size: 16.0), textColor: UIColor.darkTextColor(), kerning: -0.5, alignment: .left)
        lblTitle.setLineSpacing(lineSpacing: 1.2)
    }
}
