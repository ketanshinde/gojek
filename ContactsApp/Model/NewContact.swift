//
//  NewContact.swift
//  ContactsApp
//
//  Created by Ketan on 08/10/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation


struct NewContact: Codable {
    
    var first_name: String = ""
    var last_name: String = ""
    var email: String = ""
    var phone_number: String = ""
    var favorite: Bool = false
}
