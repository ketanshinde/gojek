//
//  Enviornment.swift
//  AStudy
//
//  Created by Ketan on 28/09/19.
//  Copyright © 2019 SAFACS. All rights reserved.
//

import Foundation


enum Environment {
    
    case development
    case staging
    case production
    
    func baseURL() -> String {
      //  return "\(urlProtocol())://\(subdomain()).\(domain())\(route())"
        return "\(urlProtocol())://\(subdomain()).\(domain())"
    }
    
    func urlProtocol() -> String {
        switch self {
        case .production:
            return "https"
        default:
            return "http"
        }
    }
    
    func domain() -> String {
        switch self {
        case .development, .staging, .production:
            return "herokuapp.com"
        }
    }
    
    func subdomain() -> String {
        switch self {
        case .development:
            return "gojek-contacts-app"
        case .staging:
            return "gojek-contacts-app"
        case .production:
            return "gojek-contacts-app"
        }
    }
    
    func route() -> String {
        return "/api/v1"
    }
    
}

extension Environment {
    func host() -> String {
        return "\(self.subdomain()).\(self.domain())"
    }
}

// MARK:- APIs

#if DEBUG
let environment: Environment = Environment.development
#else
let environment: Environment = Environment.staging
#endif

let baseUrl = environment.baseURL()
