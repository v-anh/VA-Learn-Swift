//
//  MainTweeterViewController.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/12/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit

class MainTweeterViewController: UIViewController {

    var presenter:MainTweeterPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "postTweet":
            if let navigationController = segue.destination as? UINavigationController,
                let postTweet = navigationController.viewControllers.first as? PostTweetViewController{
                postTweet.postTweetDelegate = self
            }
        default:
            break
        }
    }

}

extension MainTweeterViewController:CreateMessageDelegate {
    
    func didCreateMessages(message: [String]?) {
        
    }
    
    
}

extension MainTweeterViewController:MainTweeterViewProtocol {
    func addMessages(message: [String]) {
        
    }
    
    func reloadTweet(message: [String]) {
        
    }
    
    func showError(message: String) {
        
    }
    
    
}
