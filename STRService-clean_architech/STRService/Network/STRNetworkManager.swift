//
//  STRNetworkManager.swift
//  STRService
//
//  Created by Quyen Nguyen The on 2/22/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

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
