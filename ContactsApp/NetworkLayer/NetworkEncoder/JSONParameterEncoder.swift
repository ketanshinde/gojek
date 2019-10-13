//
//  JSONParameterEncoder.swift
//
//
//  Created by Rajshekhar on 25/04/19.
//  Copyright © 2019 Handzap Software Pvt. Ltd. All rights reserved.
//

import Foundation


public struct JSONParameterEncoder: ParameterEncoder {
    
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
            let postLength = "\(UInt(jsonAsData.count ?? 0))"
            urlRequest.addValue(postLength, forHTTPHeaderField: "Content-Length")
            urlRequest.httpBody = jsonAsData
         }
        catch {
            throw EncoderError.encodingFailed
        }
    }
}
