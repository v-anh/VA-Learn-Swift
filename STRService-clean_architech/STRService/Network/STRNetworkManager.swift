import Foundation
import Alamofire


class STRNetworkManager {
    var networkManager: SessionManager? = nil
    
    static let shared: STRNetworkManager = STRNetworkManager()
    
    func setupNetwork() {
        let configuration = URLSessionConfiguration.default
        networkManager = Alamofire.SessionManager(configuration: configuration)
    }
}
