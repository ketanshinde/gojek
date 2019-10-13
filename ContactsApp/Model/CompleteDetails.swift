//
//  ContactDetail.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation

struct CompleteDetails {
    
    var contactDetails: ContactDetails
    var arrayOtherDetail: [OtherDetail]
}

struct OtherDetail {
    
    var title: String = ""
    var description: String = ""
}
