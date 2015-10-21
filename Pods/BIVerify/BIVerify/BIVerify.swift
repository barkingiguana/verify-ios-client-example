//
//  Verify.swift
//  Verify
//
//  Created by Craig Webster on 14/10/2015.
//  Copyright © 2015 Barking Iguana. All rights reserved.
//

import Foundation

public class BIVerify {
    public static func expressIntent(verb:String, path:String, parameters:[String:String]) -> BIIntent {
        return BIIntent(verb: verb, path: path, parameters: parameters)
    }
}