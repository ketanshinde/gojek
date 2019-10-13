//
//  ContactDetailVM.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation
import UIKit

class ContactAddEditVM {
    
    var arrayItems = ["First Name", "Last Name", "mobile", "email"]

    init() {}
    
    func createDataSource() -> [OtherDetail] {
        var arrayOthers = [OtherDetail]()
        for items in arrayItems {
            
            let detailObj = OtherDetail(title: items, description: "")
            arrayOthers.append(detailObj)
        }
        return arrayOthers
    }
    
    func configureDataForTable(contactDetail: ContactDetails) -> [OtherDetail] {
        
        var arrayOthers = [OtherDetail](repeating: OtherDetail(), count: 4)
        
        if let detailsDic = JSONConverter.getJSON(fromModel: contactDetail) {
            
            for (key, value) in detailsDic  {
                
                if (value is String && key == "firstName") {
                    let otherDetailDic = OtherDetail(title: "First Name", description: value as! String)
                    arrayOthers[0] = otherDetailDic
                }
                else if (value is String && key == "lastName") {
                    let otherDetailDic = OtherDetail(title: "Last Name", description: value as! String)
                    arrayOthers[1] = otherDetailDic
                }
                else if (value is String && key == "phoneNumber") {
                    let otherDetailDic = OtherDetail(title: "mobile", description: value as! String)
                    arrayOthers[2] = otherDetailDic
                }
                else if (value is String && key == "email") {
                    let otherDetailDic = OtherDetail(title: key, description: value as! String)
                    arrayOthers[3] = otherDetailDic
                }
            }
        }
        return arrayOthers
    }
    
    func postNewContact(newContact: NewContact, completionHandler: @escaping (ContactDetails?, String?) -> ()) {
        
        let param = prepareRequestBodyForPost(typeModel: newContact)
        
        // api
        let api = URL(string: API_NEW_CONTACTS)
        
        //request
        let requestBuilder = RequestBuilder(apiURL: api!)
        let requestURL = requestBuilder.makeRequest(postParam: param, queryParam: nil, httpMethod: .post, encodingScheme: .jsonEncoding)
        
        //url data task
        let apiHandler = APIHandler(urlSession: URLSession(configuration: .default))
        apiHandler.loadAPIRequest(urlRequest: requestURL!,
                                  codableObj: ContactDetails.self) { (details, error) in
                                    
                                    if error != nil {
                                        completionHandler(nil, error?.localizedDescription)
                                    } else {
                                        if let getDetails = details {
                                            completionHandler(getDetails, nil)
                                        }
                                    }
        }
    }
    
    func updateContact(contactDetail: ContactDetails, completionHandler: @escaping (ContactDetails?, String?) -> ()) {
        
        let param = contactDetail.dictionaryRepresentation
        
        // api
        let api = URL(string: "\(API_UPDATE_CONTACTS)\(contactDetail.id!).json")
        
        //request
        let requestBuilder = RequestBuilder(apiURL: api!)
        let requestURL = requestBuilder.makeRequest(postParam: param, queryParam: nil, httpMethod: .put, encodingScheme: .jsonEncoding)
        
        //url data task
        let apiHandler = APIHandler(urlSession: URLSession(configuration: .default))
        apiHandler.loadAPIRequest(urlRequest: requestURL!,
                                  codableObj: ContactDetails.self) { (details, error) in
                                    
                                    if error != nil {
                                        completionHandler(nil, error?.localizedDescription)
                                    } else {
                                        if let getDetails = details {
                                            completionHandler(getDetails, nil)
                                        }
                                    }
        }
    }
    
    
    func updateFavorite(contactDetail: ContactDetails, isFav: Bool, completionHandler: @escaping (ContactDetails?, String?) -> ()) {
        
        let param = ["favorite": isFav]
        
        // api
        let api = URL(string: "\(API_UPDATE_CONTACTS)\(contactDetail.id!).json")
        
        //request
        let requestBuilder = RequestBuilder(apiURL: api!)
        let requestURL = requestBuilder.makeRequest(postParam: param, queryParam: nil, httpMethod: .put, encodingScheme: .jsonEncoding)
        
        //url data task
        let apiHandler = APIHandler(urlSession: URLSession(configuration: .default))
        apiHandler.loadAPIRequest(urlRequest: requestURL!,
                                  codableObj: ContactDetails.self) { (details, error) in
                                    
                                    if error != nil {
                                        completionHandler(nil, error?.localizedDescription)
                                    } else {
                                        if let getDetails = details {
                                            completionHandler(getDetails, nil)
                                        }
                                    }
        }
    }
    
    private func prepareRequestBodyForPost<T: Codable>(typeModel: T) -> Parameters? {
        return JSONConverter.getJSON(fromModel: typeModel)!
    }
    
    
}
