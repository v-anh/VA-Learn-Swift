//
//  MainTweeterPresenter.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/12/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import Foundation

class MainTweeterPresenter: MainTweeterPresenterProtocol {
    weak var view: MainTweeterViewProtocol?
    var interactor:MainTweeterInteractorInputProtocol?
    var router:MainTweeterRouterProtocol?
    
    func fetchMessae() {
        interactor?.fetchMessage()
    }
}

extension MainTweeterPresenter:MainTweeterInteractorOutputProtocol {
    func fetchMessageSucces(message: [String]) {
        view?.reloadTweet(message: message)
    }
}
