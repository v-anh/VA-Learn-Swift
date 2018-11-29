//
//  ViewController.swift
//  demoNetwork
//
//  Created by Anh Tran on 11/29/18.
//  Copyright © 2018 v.anh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetAllUser().execute(onSuccess: { (users) in
            print(users)
        }) { (error) in
            print(error)
        }
    }
}

public struct User: Codable {
    let id: Int
    let username: String
}

struct GetAllUser:VAService {
    typealias ResponseType = [User]
    var data : RequestData {
        return RequestData(path: "https://jsonplaceholder.typicode.com/users")
    }
}

public struct Account: Codable {
    let id: Int
    let amount: String
}



struct GetAccounts:VAService {
    typealias ResponseType = [Account]
    
    var data: RequestData {
        return RequestData(path: "accounturl...")
    }
}




