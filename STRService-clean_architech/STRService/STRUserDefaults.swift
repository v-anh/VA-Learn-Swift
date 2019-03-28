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
