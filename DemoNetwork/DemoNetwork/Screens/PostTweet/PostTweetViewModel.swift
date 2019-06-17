//
//  PostTweetViewModel.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/12/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import Foundation

protocol PostTweetViewable:class {
    func displayError(error:Error)
    func postTweetSucces(with message: [String]?)
}

protocol PostTweetViewModelProtocol:class {
    var view: PostTweetViewable {get}
    func postTweet(message:String)
}



class PostTweetViewModel: PostTweetViewModelProtocol {
    unowned var view: PostTweetViewable
    
    init(view:PostTweetViewable) {
        self.view = view
    }
    
    func postTweet(message:String) {
        self.view.postTweetSucces(with: [message])
    }
}

extension PostTweetViewModel {
    private func tweetValidation() {
        
    }
}
