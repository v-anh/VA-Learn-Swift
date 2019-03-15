//
//  HTTPService.swift
//  STRServiceExample
//
//  Created by Anh Tran on 3/15/19.
//

public protocol HTTPServiceType {
    func post(url: String, parameters: [String: Any], headers: [String: String]?, completion: @escaping () -> Void)
    func get(url: String, parameters: [String: Any], headers: [String: String]?, completion: @escaping () -> Void)
}

public struct HTTPService: HTTPServiceType {
    
    public func post(url: String, parameters: [String: Any], headers: [String: String]?, completion: @escaping () -> Void) {
        //Implementation logic goes here
        print("HTTPServiceType.post")
    }
    
    public func get(url: String, parameters: [String: Any], headers: [String: String]?, completion: @escaping () -> Void) {
        //Implementation logic goes here
        print("HTTPServiceType.post")
    }
}

