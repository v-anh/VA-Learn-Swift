import ObjectMapper
import STRService

struct User: Mappable {
    var id: Int = -1
    var username: String = ""
    var token: String = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id         <- map["id"]
        username    <- map["username"]
        token <- map["token"]
    }
}

class LoginService: STRService {
    typealias ResponseType = User
    
    var data : RequestData {
        return RequestData(path: "https://test.com/login", method: .get, params: [:], headers: nil)
    }
    
    init(){}
}
