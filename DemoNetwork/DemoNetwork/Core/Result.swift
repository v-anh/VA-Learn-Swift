//
//  Result.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/17/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import Foundation


enum VAError: Error {
    case noData
    case requestFailed
}

enum Result<T> {
    case success(T)
    case failed(VAError)
}
