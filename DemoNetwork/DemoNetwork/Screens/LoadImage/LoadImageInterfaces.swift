//
//  LoadImageInterfaces.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/10/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit

protocol LIViewToPresenterProtocol {
    var view:LoadImageViewController?{get set}
    var interactor:LIPresenterToInteractorProtocol?{get set}
    var rounter:LIPresenterToRouterProtocol?{get set}
    
    func loadImage(url:String)
    func loadWeb(with url:String)
}

protocol LIPresenterToviewProtocol {
    func loadImageSuccess(image:UIImage)
    
    func loadWebSuccess(data:String)
    func loadWebFailed(error:Error)
}

protocol LIPresenterToInteractorProtocol {
    var presenter:LIInteractorToPresenterProtocol?{get set}
    func downloadImage(url:String)
    
    func loadWeb(with url:String)
}

protocol LIInteractorToPresenterProtocol {
    func downloadImageSuccess(image:UIImage)
    
    func loadWebSuccess(data:Data?,error:Error?)
}

protocol LIPresenterToRouterProtocol {
    static func createModule()-> LoadImageViewController
    func showImage(image:UIImage)
}




