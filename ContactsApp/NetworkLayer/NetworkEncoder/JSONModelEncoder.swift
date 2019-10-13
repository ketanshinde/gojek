//
//  JSONModelEncoder.swift
//  AStudy
//
//  Created by Ketan on 29/09/19.
//  Copyright © 2019 SAFACS. All rights reserved.
//

import Foundation

struct JSONConverter {
    
    static func getJSON<T: Encodable>(fromModel request: T) -> Parameters? {
        
        do {
            let jsonData = try JSONEncoder().encode(request)
            let parameter = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! Parameters
            return parameter
        }
        catch {
            print(error)
            return nil
        }
    }
    
}
