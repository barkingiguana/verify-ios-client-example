//
//  Signature.swift
//  Verify
//
//  Created by Craig Webster on 14/10/2015.
//  Copyright © 2015 Barking Iguana. All rights reserved.
//

import Foundation
import CryptoSwift

class BISignature {
    static let DIGEST = "sha256"
    static let SEPARATOR = "--"
    
    let key: String
    let intent:BIIntent
    let secret:String
    let expiresAt:NSDate
    var string:String {
        get {
            let signedAtSeconds = Int(NSDate().timeIntervalSince1970)
            let expiresAtSeconds = Int(expiresAt.timeIntervalSince1970)
            let string = "\(key)\(expiresAtSeconds)\(signedAtSeconds)\(intent.string)"
            let token = doHmac(string, key: secret)
            let encodedToken = base64(token)
            let paramsArray: [String] = [
                encodedToken,
                key,
                String(expiresAtSeconds),
                String(signedAtSeconds)
            ]
            let params = paramsArray.joinWithSeparator(BISignature.SEPARATOR)
            let result = base64(params)
            return result
        }
    }
    
    init(key:String, intent:BIIntent, secret:String, expiresAt:NSDate) {
        self.key = key
        self.intent = intent
        self.secret = secret
        self.expiresAt = expiresAt
    }
    
    func base64(data: String) -> String {
        let raw = data.dataUsingEncoding(NSUTF8StringEncoding)?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        let result = raw?.stringByReplacingOccurrencesOfString("\\n", withString: "", options: NSStringCompareOptions.RegularExpressionSearch)
        return result!
    }

    func doHmac(data: String, key: String) -> String {
        let k = [UInt8](key.utf8)
        let authenticator = Authenticator.HMAC(key: k, variant: HMAC.Variant.sha256)
        let hmac = try! data.authenticate(authenticator)
        return hmac
    }
}