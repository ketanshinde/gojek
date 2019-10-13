//
//  ContactTableViewCell.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import UIKit
import SDWebImage

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var imgViewContact: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet private weak var viewBottomLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgViewContact.clipsToBounds = true
        imgViewContact.contentMode = .scaleAspectFill        
        viewBottomLine.backgroundColor = UIColor.lineSeperatorColor()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    func loadData(item: Contacts) {
 
        lblTitle.applyAttributes([item.firstName,item.lastName]
        .compactMap { $0 }
        .joined(separator: " "), font: UIFont.customBoldFont(size: 14.0), textColor: UIColor.darkTextColor(), kerning: -0.4)
        lblTitle.setLineSpacing(lineSpacing: 1.1)
        
        if let imgURL = item.profilePic {
            imgViewContact.sd_setImage(with: URL.init(string: imgURL), placeholderImage: UIImage(named: "placeholder_photo"))
        } else {
            imgViewContact.image = UIImage(named: "placeholder_photo")
        }
        
        btnFav.isHidden = !item.favorite!
     }
}
