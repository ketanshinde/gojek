//
//  FavContactTableProtocol.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation
import UIKit

class ContactEditTableProtocol: NSObject, UITableViewDataSource, UITableViewDelegate {

    var arrayDetails = [OtherDetail]()
    var kCellHeight: CGFloat = 56
    var kHeaderHeight: CGFloat = 186
    var editableContact: ContactDetails!
    var imageURLStr: String = ""


    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayDetails.count > 0 {
            return arrayDetails.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactAddEditHeader.identifier) as? ContactAddEditHeader {
            cell.selectionStyle = .none
            cell.frame = CGRect(x: 0, y: 0, width: Utils.screenWidth(), height: kHeaderHeight)
            cell.imgViewContact.sd_setImage(with: URL.init(string: imageURLStr), placeholderImage: UIImage(named: "placeholder_photo"))
           headerView.addSubview(cell)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactAddEditCell.identifier, for: indexPath) as? ContactAddEditCell {
            cell.selectionStyle = .none
            cell.accessoryType = .none
            cell.tag = indexPath.row
            self.cellUpdations(cell: cell, indexPath: indexPath)
            return cell
        }
       return UITableViewCell()
    }
    
    func cellUpdations(cell: ContactAddEditCell, indexPath: IndexPath) {
        
        cell.loadOtherData(item: arrayDetails[indexPath.row])
        cell.firstText = { [weak self] (text) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.arrayDetails[0].description = text
            strongSelf.editableContact.firstName = text
            
        }
        cell.lastText = { [weak self] (text) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.arrayDetails[1].description = text
            strongSelf.editableContact.lastName = text

        }
        cell.mobileText = { [weak self] (text) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.arrayDetails[2].description = text
            strongSelf.editableContact.phoneNumber = text

        }
        cell.emailText = { [weak self] (text) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.arrayDetails[3].description = text
            strongSelf.editableContact.email = text

        }
        
    }
    
    
}
