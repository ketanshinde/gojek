//
//  APILoader.swift
//  AStudy
//
//  Created by ketan shinde on 23/09/19.
//  Copyright © 2019 SAFACS. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

// MARK: - HTTPMethods
public enum HTTPMethod : String {
    
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}


// MARK: - Request Headers
protocol Builder {
    func setHeaders(request: inout URLRequest)
}

class Request {
    
    private var request: URLRequest
    
    var urlRequest: URLRequest {
        return request
    }
    init(urlRequest: URLRequest, requestBuilder: Builder) {
        self.request = urlRequest
        requestBuilder.setHeaders(request: &self.request)
    }
}

class DefaultRequest: Builder {
    
    func setHeaders(request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        /*
         request.setValue(AppHelper.getDeviceID(), forHTTPHeaderField: "DeviceId")
         request.setValue(AppHelper.getCurrentLanguage(), forHTTPHeaderField: "DeviceLanguage")
        */
    }
}

class AuthRequest: DefaultRequest {
    
    override func setHeaders(request: inout URLRequest) {
        super.setHeaders(request: &request)
        /*
         let token = SharedData.shared().token!
         request.setValue(token, forHTTPHeaderField: "AuthToken")
       */
    }
}


// MARK: - Request Builder
struct RequestBuilder {
        
    let apiURL: URL
    
    init(apiURL: URL) {
        self.apiURL = apiURL
    }
    
    func makeRequest ( postParam: Parameters?,
                       queryParam: Parameters?,
                       httpMethod: HTTPMethod,
                       encodingScheme: ParameterEncoding ) -> URLRequest? {
        // prepare request
        var urlRequest = URLRequest(url: apiURL)
        
        // set http method
        urlRequest.httpMethod = httpMethod.rawValue
        
        // set body params / query params
        do {
            switch encodingScheme {
            case .jsonEncoding:
                try configureParameters(bodyParameters: postParam, bodyEncoding: encodingScheme, urlParameters: nil, request: &urlRequest)
            case .urlEncoding:
                try configureParameters(bodyParameters: nil, bodyEncoding: encodingScheme, urlParameters: queryParam, request: &urlRequest)
            case .urlAndJsonEncoding:
                try configureParameters(bodyParameters: postParam, bodyEncoding: encodingScheme, urlParameters: queryParam, request: &urlRequest)
            case .normal:
                break
            }
            
            // prepares request (sets header params, any additional configurations)
            let getRequest = Request(urlRequest: urlRequest, requestBuilder: DefaultRequest()).urlRequest
            return getRequest
        }
        catch let error {
            print("ERROR: \(error.localizedDescription)")
            return nil
        }
        
    }
    
    
    private func configureParameters(bodyParameters: Parameters?,
                                     bodyEncoding: ParameterEncoding,
                                     urlParameters: Parameters?,
                                     request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
}


