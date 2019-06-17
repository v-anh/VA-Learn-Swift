//
//  MainTweeterRouter.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/12/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit
class MainTweeterRouter: MainTweeterRouterProtocol {
    weak var view:MainTweeterViewController?
    static func createModule() -> MainTweeterViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MainTweeterViewController") as? MainTweeterViewController else {
            fatalError("MainTweeterViewController doesnt exist!")
        }
        let presenter = MainTweeterPresenter()
        let interactor = MainTweeterInteractor()
        let router = MainTweeterRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc
        interactor.presenter = presenter
        router.view = vc
        vc.presenter = presenter
        return vc
    }
    
    func showCreateMessageView(with delegate: CreateMessageDelegate) {
        
    }
    
    
}
