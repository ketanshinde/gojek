//
//  ContactDetailVM.swift
//  ContactsApp
//
//  Created by ketan shinde on 15/09/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation

class ContactDetailVM {
  
    var fetchHandler:((String?) -> Void)?
    var contactDetail: ContactDetails!
    
    init() {}
    
    func fetchContactDetails(contactId: Int) {
        
        // api
        let api = URL(string: "\(API_CONTACT_DETAILS)\(contactId).json")
        
        //request
        let requestBuilder = RequestBuilder(apiURL: api!)
        let requestURL = requestBuilder.makeRequest(postParam: nil, queryParam: nil, httpMethod: .get, encodingScheme: .normal)
        
        //url data task
        let apiHandler = APIHandler(urlSession: URLSession(configuration: .default))
        apiHandler.loadAPIRequest(urlRequest: requestURL!, codableObj: ContactDetails.self) { (details, error) in
            
            if let getDetails = details {
                self.contactDetail = getDetails
                self.fetchHandler?(error?.localizedDescription)
            }
        }
    }
    
    
    func configureDataForTable() -> [CompleteDetails]{
        
        var arrayDetails = [CompleteDetails]()
        var arrayOthers = [OtherDetail](repeating: OtherDetail(), count: 2)

        if let detailsDic = JSONConverter.getJSON(fromModel: contactDetail) {
            
            for (key, value) in detailsDic  {
                
                if (value is String && key == "phoneNumber") {
                    let otherDetailDic = OtherDetail(title: "mobile", description: value as! String)
                    arrayOthers[0] = otherDetailDic
                }
                else if (value is String && key == "email") {
                    let otherDetailDic = OtherDetail(title: key, description: value as! String)
                    arrayOthers[1] = otherDetailDic
                }
            }
        }
        
        let personDetails = CompleteDetails(contactDetails: contactDetail, arrayOtherDetail: arrayOthers)
        arrayDetails.append(personDetails)
        return arrayDetails
    }
    
    
}
