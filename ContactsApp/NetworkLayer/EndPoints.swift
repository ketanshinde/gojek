//
//  AppConstants.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation
import UIKit

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate

var API_CONTACTS: String { return "\(baseUrl)/contacts.json" }
var API_CONTACT_DETAILS: String { return "\(baseUrl)/contacts/" }
var API_NEW_CONTACTS: String { return "\(baseUrl)/contacts.json" }
var API_UPDATE_CONTACTS: String { return "\(baseUrl)/contacts/" }
