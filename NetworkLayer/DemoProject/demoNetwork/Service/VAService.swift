//
//  VAService.swift
//  demoNetwork
//
//  Created by Anh Tran on 11/29/18.
//  Copyright © 2018 v.anh. All rights reserved.
//

import Foundation


public enum ConnError:Swift.Error {
    case invalidURL
    case noData
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

/*
 REQUEST DATA
 */
public struct RequestData {
    public let path:String
    public let method:HTTPMethod
    public let params:[String:Any?]?
    public let headers: [String: String]?
    
    init(path: String,
         method: HTTPMethod = .get,
         params: [String: Any?]? = nil,
         headers: [String: String]? = nil) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
    }
}


public protocol VAService {
    associatedtype ResponseType: Codable
    var data: RequestData { get }
}

public extension VAService {
    public func execute(dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
                        onSuccess: @escaping (ResponseType) -> Void,
                        onError: @escaping (Error) -> Void) {
        dispatcher.dispatch(request: self.data, onSuccess: { (data) in
            do {
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    onSuccess(result)
                }
            } catch let error {
                DispatchQueue.main.async {
                    onError(error)
                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                onError(error)
            }
        }
    }
}

public protocol NetworkDispatcher {
    func dispatch(request:RequestData, onSuccess:@escaping (Data) -> Void,onError:@escaping (Error) -> Void)
}

public struct URLSessionNetworkDispatcher : NetworkDispatcher {
    
    public static let instance = URLSessionNetworkDispatcher()
    
    private init() {}
    
    public func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = URL(string: request.path) else {
            onError(ConnError.invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        do {
            if let params = request.params {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        } catch let error {
            onError(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                onError(error)
                return
            }
            
            guard let _data = data else {
                onError(ConnError.noData)
                return
            }
            
            onSuccess(_data)
            }.resume()
    }
}


