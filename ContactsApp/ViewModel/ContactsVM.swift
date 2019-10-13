//
//  PopularContactsVM.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation

class ContactsVM {
    
    var fetchHandler:((String?) -> Void)?
    var arrayContacts: [Contacts] = []
    
    init() {}
    
    func fetchContacts() {
        // api
        let api = URL(string: API_CONTACTS)
        
        //request
        let requestBuilder = RequestBuilder(apiURL: api!)
        let requestURL = requestBuilder.makeRequest(postParam: nil, queryParam: nil, httpMethod: .get, encodingScheme: .normal)
        
        //url data task
        let apiHandler = APIHandler(urlSession: URLSession(configuration: .default))
        apiHandler.loadAPIRequest(urlRequest: requestURL!, codableObj: [Contacts].self) { (contacts, error) in
            
            if let getArryContact = contacts {
                self.arrayContacts = getArryContact
                self.fetchHandler?(error?.localizedDescription)
            }
        }
    }
    
    
    func indexingContacts(completionHandler: ([String: [Contacts]], [String]) -> ()) {
        
        var contactSectionTitles = [String]()
        var contactDictionary = [String: [Contacts]]()
        
        for contact in arrayContacts {
            let nameKey = String(contact.firstName!.prefix(1))
            
            if var contactValues = contactDictionary[nameKey] {
                contactValues.append(contact)
                contactDictionary[nameKey] = contactValues
            } else {
                contactDictionary[nameKey] = [contact]
            }
        }
        
        contactSectionTitles = [String](contactDictionary.keys)
        contactSectionTitles = contactSectionTitles.sorted(by: { $0 < $1 })
        
        completionHandler(contactDictionary, contactSectionTitles)
    }
    
}
