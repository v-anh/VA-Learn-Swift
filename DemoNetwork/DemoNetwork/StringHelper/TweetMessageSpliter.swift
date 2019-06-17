//
//  TweetMessageSpliter.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/12/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import Foundation

enum SplitResult<T> {
    case sucess(T)
    case failed(Error)
}

protocol TweetMessageSplitable {
    func splitMessage(message:String) -> SplitResult<[String]>
}
