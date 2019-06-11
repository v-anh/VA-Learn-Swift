//
//  iTuneSearchRouter.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/11/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit
class iTuneSearchRouter: iTuneSearchPresenterToRouter {
    static func createModule() -> iTuneSearchViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "iTuneSearchViewController") as? iTuneSearchViewController else {
            fatalError("iTuneSearchViewController doesnt exist!")
        }
        let presenter : iTuneSearchInteractorToPresenter & iTuneSearchViewToPresenter = iTuneSearchPresenter()
        let interactor: iTuneSearchPresenterToInteractor = iTuneSearchInteractor()
        let router: iTuneSearchPresenterToRouter = iTuneSearchRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc
        interactor.presenter = presenter
        vc.presenter = presenter
        return vc
    }
    
    func showPlayTrack() {
        
    }
}
