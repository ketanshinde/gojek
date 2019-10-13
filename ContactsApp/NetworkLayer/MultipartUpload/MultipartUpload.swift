//
//  MutipartUpload.swift
//  Handzap
//
//  Created by ketan shinde on 07/06/19.
//  Copyright © 2019 Handzap Software Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

class MultipartUpload {
    
    private init() {}
    static let shared = MultipartUpload()
    
    var fileData: Data? = nil
    var fileName: String = ""
    var mimeType: String = ""
    
    func convertImageToData (imageFile: UIImage?) {
        
        guard let img = imageFile else {
            print("Couldn't find Image")
            return
        }
        if let data = img.jpegData(compressionQuality: 0.75) {
            fileData = data
        }
        
        let timeInterval = Date().timeIntervalSince1970*1000
        let imageFileName = String(format: "HZ-%.0f.jpeg", timeInterval)
        fileName = imageFileName
        mimeType = "jpeg"
    }
    
    func postMultiPartdata(strURL: String, postdatadictionary: [String: Any], completion: @escaping NetworkRouterCompletion) {
        
        let url = URL(string: strURL)
       
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        
        let boundary = "---------------------------14737809831466499882746641449"
        let contentType = "multipart/form-data; boundary=\(boundary)"
        urlRequest.addValue(contentType, forHTTPHeaderField: "Content-Type")
     //   urlRequest.addValue("Bearer " + HZHeaderUtils().getAccessToken(), forHTTPHeaderField: "Authorization")

        let body = NSMutableData()
        for (key, value) in postdatadictionary {
            
            if(value is Data) {
                body.append("--\(boundary)\r\n".data(using: .utf8, allowLossyConversion: false)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8, allowLossyConversion: false)!)
                body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8, allowLossyConversion: false)!)
                body.append(value as! Data)
                body.append("\r\n".data(using: .utf8, allowLossyConversion: false)!)
            }
            else {
                if let anEncoding = "--\(boundary)\r\n".data(using: .utf8, allowLossyConversion: false) {
                    body.append(anEncoding)
                }
                if let anEncoding = "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8, allowLossyConversion: false) {
                    body.append(anEncoding)
                }
                if let aKey = postdatadictionary[key], let anEncoding = "\(aKey)".data(using: .utf8, allowLossyConversion: false) {
                    body.append(anEncoding)
                }
                if let anEncoding = "\r\n".data(using: .utf8, allowLossyConversion: false) {
                    body.append(anEncoding)
                }
            }
        }
        if let anEncoding = "--\(boundary)--\r\n".data(using: .utf8, allowLossyConversion: false) {
            body.append(anEncoding)
        }

        urlRequest.httpBody = body as Data
        NetworkLogger.log(request: urlRequest)

        URLSession.shared.dataTask(with:urlRequest) { (data, response, error) in
            print("DATA: \(data)")
            print("RESPONSE: \(response)")
            print("ERROR: \(error)")

            completion(data, response, error)
        }.resume()
    }
    
}

