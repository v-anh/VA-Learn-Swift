//
//  VANetwork.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/3/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import Foundation

typealias CompletionHandler = ((_ result:Data?,_ error:Error?) -> Void)

class VANetworkWithConfig:NSObject {
    
    //-MARK: TODO
    /*
     How to free Session
     How to work with generic Data
     How to config the Session
     */
    
    var complete:CompletionHandler?
    
    var receivedData: Data?
    
    private lazy var session:URLSession = {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = TimeInterval(10)
        config.timeoutIntervalForResource = TimeInterval(20)
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    var dataTask: URLSessionDataTask?
    
    func load(url:String, complete: @escaping CompletionHandler){
        dataTask?.cancel()
        self.complete = complete
        let url = URL(string: url)!
        receivedData = Data()
        dataTask = session.dataTask(with: url)
        dataTask?.resume()
    }
    
    func load(url:URL, complete: @escaping CompletionHandler){
        dataTask?.cancel()
        self.complete = complete
        receivedData = Data()
        
        dataTask = session.dataTask(with: url)
        dataTask?.resume()
    }
}

extension VANetworkWithConfig:URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        guard let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode) else {
                completionHandler(.cancel)
                return
        }
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.receivedData?.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let complete = self.complete else {
            return
        }
        dataTask = nil
        DispatchQueue.main.async {
            complete(self.receivedData,error)
        }
    }
    
}



