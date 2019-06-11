//
//  LoadImageRouter.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/10/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit

class LoadImageRouter: LIPresenterToRouterProtocol {
    static func createModule() -> LoadImageViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "LoadImageViewController") as? LoadImageViewController else {
            fatalError("LoadImageViewController doesnt exist!")
        }
        var presenter : LIViewToPresenterProtocol & LIInteractorToPresenterProtocol = LoadImagePresenter()
        var interactor: LIPresenterToInteractorProtocol = LoadImageInteractor()
        let router: LIPresenterToRouterProtocol = LoadImageRouter()
        
        presenter.interactor = interactor
        presenter.rounter = router
        presenter.view = vc
        interactor.presenter = presenter
        vc.presenter = presenter
        return vc
    }
    
    func showImage(image: UIImage) {
        
    }
}
