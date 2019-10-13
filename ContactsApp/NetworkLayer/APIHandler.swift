//
//  APIHandler.swift
//  AStudy
//
//  Created by ketan shinde on 25/09/19.
//  Copyright © 2019 SAFACS. All rights reserved.
//

import Foundation

enum HttpStatusCode: Int {
    case serverInternalError = 500
    case notFound = 404
    case validationError = 422
    case offlineError = 1001
    case noDataFound = 1002
    case otherError = 1003
    case dataConversionError = 1004

    var localizedDescription: String {
           switch self {
           case .serverInternalError: return "Internal Server Error"
           case .notFound: return "Not Found"
           case .validationError: return "Validation Errors"
           case .offlineError: return "Internet is not available"
           case .otherError: return "Something went Wrong"
           case .noDataFound: return "No Data found"
           case .dataConversionError: return "Data Conversion Error"
        }
    }
}


// MARK: - URL Session
    
class APIHandler {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
   func loadAPIRequest<T: Codable> (urlRequest: URLRequest,
                                     codableObj: T.Type,
                                     completionHandler: @escaping (T?, HttpStatusCode?) -> ()) {
        
        if !Utils.isOnline() {
            return completionHandler(nil, .offlineError)
        }
    
        NetworkLogger.log(request: urlRequest)
        urlSession.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                
                if error != nil {
                    return completionHandler(nil, .otherError)
                }
                
                if self.isSuccessCode(response) {
                    guard let data = data else {
                        return completionHandler(nil, .noDataFound)
                    }
                    ResponseParser.JSONResponse(responseData: data)
                    do {
                        let parsedResponse = try ResponseParser.defaultParseResponse(responseData: data, type:  codableObj)
                        return completionHandler(parsedResponse, nil)
                    }
                    catch {
                        return completionHandler(nil, .dataConversionError)
                    }
                }
                else {
                    
                    switch self.getHttpStatusCode(response) {
                        
                    case HttpStatusCode.serverInternalError.rawValue:
                        return completionHandler(nil, .serverInternalError)
                        
                    case HttpStatusCode.notFound.rawValue:
                        return completionHandler(nil, .notFound)
                        
                    case HttpStatusCode.validationError.rawValue:
                        return completionHandler(nil, .validationError)
                    
                    default:
                        break
                    }
                }
                
            }
        }.resume()
    }
    
    
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    
    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
    
    private func getHttpStatusCode(_ response: URLResponse?) -> Int {
        guard let urlResponse = response as? HTTPURLResponse else {
            return 0
        }
        return urlResponse.statusCode
    }
}


// MARK: - Parser

struct ResponseParser {
    
    static func defaultParseResponse <T: Codable> (responseData: Data, type: T.Type) throws -> T? {
        
            let inISOLatin = String(data: responseData, encoding: .isoLatin1)
            guard let inUTF8Format = inISOLatin?.data(using: .utf8) else {
                print("could not convert data to UTF-8 format")
                return nil
            }
            return try JSONDecoder().decode(type, from: inUTF8Format)
    }
    
    static func JSONResponse(responseData: Data) {
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
            print("RESPONSE: \(jsonData)")
        } catch {
            print(error)
        }
    }
    
    
}

