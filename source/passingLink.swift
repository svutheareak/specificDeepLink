//
//  passingLink.swift
//  specificDeepLink
//
//  Created by Sam Vutheareak on 11/9/23.
//

import Foundation

open class specificLink: NSObject {
    @objc static public let shared = specificLink.init()
    
    var appID:String = ""
    
    @objc public func setAppID(AppName:String){
        appID = AppName
    }
    
    @objc public func openPrinceBank(order: String) {
        print("xdbank://rrpay?orderNo=\(order)&urlScheme=\(self.appID)://openpage")
        UIApplication.shared.open(URL.init(string: "xdbank://rrpay?orderNo=\(order)&urlScheme=\(self.appID)://openpage")!, options: [:]) { success in
            guard success else {
                UIApplication.shared.open(URL.init(string: "itms-apps://itunes.apple.com/app/id1480524848")!, options: [:], completionHandler: nil)
                return
            }
        }
    }
    
    @objc public func handlePay(url:URL ,complete: (_ status:String)->Swift.Void) {
        if url.absoluteString.hasPrefix("\(String(describing: self.appID))") {
            let query:String = url.query!
            let array:[String] = query.components(separatedBy: "=")
            complete(array[1])
        }
    }
    
    
}
