//
//  LoadImagePresenter.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/10/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit

class LoadImagePresenter: LIViewToPresenterProtocol {
    
    var view: LoadImageViewController?
    
    var interactor: LIPresenterToInteractorProtocol?
    
    var rounter: LIPresenterToRouterProtocol?
    
    func loadImage(url: String) {
        
    }
    
    func loadWeb(with url: String) {
        interactor?.loadWeb(with: url)
    }
    
}

extension LoadImagePresenter: LIInteractorToPresenterProtocol {
    func loadWebSuccess(data: Data?, error: Error?) {
        if let error = error {
            print("LoadImagePresenter loadWebFailed: \(error)")
            view?.loadWebFailed(error: error)
            return
        }
        guard let data = data,let string = String(data: data, encoding: .utf8) else {
            print("LoadImagePresenter loadWebSuccess but there some thing hanpen with data")
            return
        }
        view?.loadWebSuccess(data: string)
    }
    
    func downloadImageSuccess(image: UIImage) {
        
    }
}
