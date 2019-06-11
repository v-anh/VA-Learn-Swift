//
//  LoadImageViewController.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/10/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit
import WebKit
class LoadImageViewController: UIViewController {

    let url = "https://www.apple.com/"
    var presenter : LIViewToPresenterProtocol?
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var urlInput: UITextField!
    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadWeb(with: url)
    }

    @IBAction func goAction(_ sender: Any) {
        goButton.isEnabled = false
        loading.startAnimating()
        presenter?.loadWeb(with: urlInput.text ?? url)
    }
}


extension LoadImageViewController:LIPresenterToviewProtocol {
    func loadImageSuccess(image: UIImage) {
        
    }
    
    func loadWebSuccess(data: String) {
        self.goButton.isEnabled = true
        self.loading.stopAnimating()
        self.webView.loadHTMLString(data, baseURL: nil)
        
    }
    
    func loadWebFailed(error: Error) {
        
        self.goButton.isEnabled = true
        self.loading.stopAnimating()
        self.webView.stopLoading()
    }
}
