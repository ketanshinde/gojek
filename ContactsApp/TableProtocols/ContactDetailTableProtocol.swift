//
//  FavContactTableProtocol.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailTableProtocol: NSObject, UITableViewDataSource, UITableViewDelegate {

    var arrayDetails = [CompleteDetails]()
    var kCellHeight: CGFloat = 56
    var kHeaderHeight: CGFloat = 335

    override init() {
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayDetails.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayDetails.count > 0 {
            return arrayDetails[section].arrayOtherDetail.count
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

        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactHeaderCell.identifier) as? ContactHeaderCell {
            cell.selectionStyle = .none
            cell.loadData(item: arrayDetails[section].contactDetails)
            cell.frame = CGRect(x: 0, y: 0, width: Utils.screenWidth(), height: kHeaderHeight)
            headerView.addSubview(cell)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactDetailsCell.identifier, for: indexPath) as? ContactDetailsCell {
            cell.selectionStyle = .none
            cell.accessoryType = .none
            
            let detailInfo = arrayDetails[indexPath.section].arrayOtherDetail[indexPath.row]
            cell.loadOtherData(item: detailInfo)
            return cell
        }
       return UITableViewCell()
    }
    
    
}
