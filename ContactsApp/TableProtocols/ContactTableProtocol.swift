//
//  ContactsTableProtocol.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation
import UIKit

class ContactTableProtocol: NSObject, UITableViewDelegate, UITableViewDataSource {

    var contactSectionTitles = [String]()
    var contactDictionary = [String: [Contacts]]()
    var kCellHeight: CGFloat = 64
    
    override init() {
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // 1
        return contactSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let nameKey = contactSectionTitles[section]
        if let nameValues = contactDictionary[nameKey] {
            return nameValues.count
        }
            
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contactSectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contactSectionTitles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell {
            cell.selectionStyle = .none
            cell.accessoryType = .none
            
            let nameKey = contactSectionTitles[indexPath.section]
            if let contactsList = contactDictionary[nameKey] {
             cell.loadData(item: contactsList[indexPath.row])
            }
            
            return cell
        }
       return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = AppDelegate.mainStoryboard.instantiateViewController(withIdentifier: "ContactDetailVC") as! ContactDetailVC
        
        let nameKey = contactSectionTitles[indexPath.section]
        if let contactsList = contactDictionary[nameKey] {
            viewController.contactID = contactsList[indexPath.row].id!
            APP_DELEGATE.appNavController?.pushViewController(viewController, animated: true)
        }
        
    }
}
