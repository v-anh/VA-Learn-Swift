import ObjectMapper
import STRService

struct Profile: Mappable {
    var fullname: String = ""
    var avatar: String = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        fullname    <- map["fullname"]
        avatar    <- map["avatar"]
    }
}

class ProfileService: STRService {
    
    override var path: String {
        return "profile"
    }
}
