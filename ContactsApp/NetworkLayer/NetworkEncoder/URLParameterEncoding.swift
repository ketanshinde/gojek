//
//  URLParameterEncoding.swift
//
//
//  Created by Rajshekhar on 25/04/19.
//  Copyright © 2019 Handzap Software Pvt. Ltd. All rights reserved.
//

import Foundation


public struct URLParameterEncoder: ParameterEncoder {
   
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw EncoderError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            
            var queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                queryItems.append(URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)))
            }
            urlComponents.queryItems = queryItems
            let urlString = urlComponents.url?.absoluteString.replacingOccurrences(of: "%2520", with: "%20")
            urlRequest.url = URL(string: urlString!)
        }
    }

}
