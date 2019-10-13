//
//  Utils.swift
//  ContactsApp
//
//  Created by Ketan on 05/10/19.
//  Copyright © 2019 ketan shinde. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit

class Utils {
    
    // MARK: - ONLINE
    class func isOnline() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    class func createLayerOfGradient(width: CGFloat, height: CGFloat) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        layer.colors = [UIColor.white.cgColor, UIColor.seaGreenColor().cgColor]
        return layer
    }
    
    // MARK: - SCREEN WIDTH
    class func screenWidth() -> CGFloat
    {
        return UIScreen.main.bounds.size.width
    }
    
    // MARK: - SCREEN HEIGHT
    class func screenHeight() -> CGFloat
    {
        return UIScreen.main.bounds.size.height
    }
    
   class func getTopController() -> UIViewController? {
        
        if let topController = UIApplication.topViewController() {
            return topController
        } else {
            return nil
        }
    }
    
}

extension UIViewController {
    
     func showAlertWithText(text: String) {
           
           let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
}
