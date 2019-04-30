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

final class LoginService: STRService {
    
    override var path: String {
        return "login"
    }
}

