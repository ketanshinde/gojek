//
//  UIImage+Base64.swift
//  ContactsApp
//
//  Created by Ketan on 10/10/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}
