//
//  LoadImageInteractor.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/10/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import Foundation
class LoadImageInteractor: LIPresenterToInteractorProtocol {
    
    
    var presenter: LIInteractorToPresenterProtocol?
    
    func downloadImage(url: String) {
        let demoLoad = VANetworkWithConfig()
        demoLoad.load(url: url) { (data, error) in
            
        }
    }
    
    func loadWeb(with url: String) {
        let demoLoad = VANetworkWithConfig()
        demoLoad.load(url: url) { (data, error) in
            self.presenter?.loadWebSuccess(data: data, error: error)
        }
    }
}
