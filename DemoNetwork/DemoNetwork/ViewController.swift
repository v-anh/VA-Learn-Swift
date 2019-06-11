//
//  ViewController.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/3/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController {

    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var webview: WKWebView!
    
    var receivedData: Data?
    
    private lazy var session:URLSession = {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    func load(){
        let url = URL(string: "https://www.apple.com/")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    
                    return
            }
            if let mimeType = httpResponse.mimeType, mimeType == "text/html",
                let data = data,
                let string = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self.webview.loadHTMLString(string, baseURL: url)
                }
            }
        }
        task.resume()
    }
    
    
    func startLoad() {
        loadButton.isEnabled = false
        let url = URL(string: "https://www.apple.com/")!
        receivedData = Data()
        let task = session.dataTask(with: url)
        task.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLoad()
    }


}

extension ViewController:URLSessionDataDelegate {
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
        DispatchQueue.main.async {
            self.loadButton.isEnabled = true
            if let error = error {
                print(error)
            } else if let receivedData = self.receivedData,
                let string = String(data: receivedData, encoding: .utf8) {
                self.webview.loadHTMLString(string, baseURL: task.currentRequest?.url)
            }
        }
    }
    
}

