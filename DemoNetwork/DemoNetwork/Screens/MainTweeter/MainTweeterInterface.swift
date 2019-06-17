//
//  MainTweeterInterface.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/12/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import Foundation

protocol CreateMessageDelegate:class {
    func didCreateMessages(message:[String]?)
}

//MARK: Presenter
protocol MainTweeterPresenterProtocol : class {
    //VIEW -> PRESENTER
    var view: MainTweeterViewProtocol? {get set}
    var interactor:MainTweeterInteractorInputProtocol? {get set}
    var router:MainTweeterRouterProtocol? {get set}
    
    func fetchMessae()
}
protocol MainTweeterViewProtocol : class{
    //PRESENTER -> VIEW
    func reloadTweet(message:[String])
    func showError(message:String)
    
    func addMessages(message:[String])
}

protocol MainTweeterInteractorInputProtocol : class {
    var presenter:MainTweeterInteractorOutputProtocol? {get set}
    //PRESENTER -> INTERACTOR
    func fetchMessage()
}

protocol MainTweeterInteractorOutputProtocol : class {
    //INTERACTOR -> PRESENTER
    func fetchMessageSucces(message:[String])
}

protocol MainTweeterRouterProtocol : class {
    //PRESENTER -> ROUTER
    static func createModule() -> MainTweeterViewController
    
    func showCreateMessageView(with delegate:CreateMessageDelegate)
}

