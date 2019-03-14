//
//  ListProductsInterfaces.swift
//  STRServiceExample
//
//  Created by Tran Viet Anh on 2019/03/11.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import UIKit
import STRService

protocol ListProductsDisplayable:class, AppDisplayable { //ViewController
    func displayFetchedProducts(with viewModel: ListProductsModels.ViewModel)
    func displaySearchedProducts(with viewModel: ListProductsModels.ViewModel)
}

protocol ListProductsBusinessLogic{ //Interactor
    func fetchProduct(with request:ListProductsModels.FetchRequest)
}

protocol ListProductsPresentable { //Presenter
    func presentFetchedProducts(for response:ListProductsModels.Response)
    func presentFetchedProducts(for error:Error)
}

protocol ListProductsRoutable:AppRoutable {
    func showProduct(id:String)
}
