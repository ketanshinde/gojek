//
//  ContactDetail.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation

struct ContactDetails: Codable {
    
    var id: Int?
    var firstName: String?
    var lastName: String?
    var email: String?
    var phoneNumber: String?
    var profilePic: String?
    var favorite: Bool?
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "id" : id!,
            "first_name" : firstName!,
            "last_name" : lastName!,
            "email" : email!,
            "phone_number" : phoneNumber!,
            "profile_pic" : profilePic!,
        ]
    }
    
    enum ContactDetailsCodingKeys: String, CodingKey {
        
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case phoneNumber = "phone_number"
        case profilePic = "profile_pic"
        case favorite
    }
    
    init(from decoder: Decoder) throws {
    
        let contactContainer = try decoder.container(keyedBy: ContactDetailsCodingKeys.self)
        
        id = contactContainer.contains(.id) ? try contactContainer.decodeIfPresent(Int.self, forKey: .id) : 0
        
        firstName = contactContainer.contains(.firstName) ? try contactContainer.decodeIfPresent(String.self, forKey: .firstName) : ""
        lastName = contactContainer.contains(.lastName) ? try contactContainer.decodeIfPresent(String.self, forKey: .lastName) : ""
        
        email = contactContainer.contains(.email) ? try contactContainer.decodeIfPresent(String.self, forKey: .email) : ""
        phoneNumber = contactContainer.contains(.phoneNumber) ? try contactContainer.decodeIfPresent(String.self, forKey: .phoneNumber) : ""
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
    }
}
