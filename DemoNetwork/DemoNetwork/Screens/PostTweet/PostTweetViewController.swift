//
//  PostTweetViewController.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/12/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit

class PostTweetViewController: UIViewController {

    weak var postTweetDelegate:CreateMessageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PostTweetViewController:PostTweetViewable {
    func displayError(error: Error) {
        
    }
    
    func postTweetSucces(with message: [String]?) {
        self.dismiss(animated: true) {
            if let delegate = self.postTweetDelegate {
                delegate.didCreateMessages(message: message)
            }
        }
    }
    
    
}


