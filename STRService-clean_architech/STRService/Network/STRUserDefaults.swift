//
//  STRUserDefault.swift
//  STRService
//
//  Created by Ngo Chi Hai on 2/28/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import Foundation

extension UserDefaults {
    class func setToken(token: String) {
        UserDefaults.standard.set(token, forKey: "strToken")
    }
    
    class func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "strToken")
    }
    
    class func setLoopValue(value: Int) {
        UserDefaults.standard.set(value, forKey: "strLoop")
    }
    
    class func getLoopValue() -> Int {
        return UserDefaults.standard.integer(forKey: "strLoop")
    }
}
