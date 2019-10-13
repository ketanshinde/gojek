//
//  Contacts.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation

struct Contacts: Codable, Equatable {
    
    var id: Int?
    var firstName: String?
    var lastName: String?
    var profilePic: String?
    var favorite: Bool?
    var url: String?
    
    enum ContactsCodingKeys: String, CodingKey {
        
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case favorite
        case url
    }
    
    init(id: Int = 0, firstName: String = "", lastName: String = "",
         profilePic: String = "", favorite: Bool = false, url: String = "") {
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.profilePic = profilePic
        self.favorite = favorite
        self.url = url
    }
    
    init(from decoder: Decoder) throws {
    
        let contactContainer = try decoder.container(keyedBy: ContactsCodingKeys.self)
        
        id = contactContainer.contains(.id) ? try contactContainer.decodeIfPresent(Int.self, forKey: .id) : 0
        
        firstName = contactContainer.contains(.firstName) ? try contactContainer.decodeIfPresent(String.self, forKey: .firstName) : ""
        lastName = contactContainer.contains(.lastName) ? try contactContainer.decodeIfPresent(String.self, forKey: .lastName) : ""
        profilePic = contactContainer.contains(.profilePic) ? try contactContainer.decodeIfPresent(String.self, forKey: .profilePic) : ""
        
        do {
            favorite = try contactContainer.decodeIfPresent(Bool.self, forKey: .favorite)
        } catch DecodingError.typeMismatch {
            if let getVal = try contactContainer.decodeIfPresent(Int.self, forKey: .favorite) {
                if getVal == 1 {
                    favorite = true
                } else {
                    favorite = false
                }
            }
        }
        
        url = contactContainer.contains(.url) ? try contactContainer.decodeIfPresent(String.self, forKey: .url) : ""
    }
}

extension Contacts {
    static func ==(lhs: Contacts, rhs: Contacts) -> Bool {
        return lhs.id == rhs.id && lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName &&
            lhs.profilePic == rhs.profilePic && lhs.favorite == rhs.favorite && rhs.url == lhs.url
    }
}
