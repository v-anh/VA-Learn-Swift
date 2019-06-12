//
//  iTuneSearchRouter.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/11/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit
import AVKit

class iTuneSearchRouter: iTuneSearchPresenterToRouter {
    weak var navigationController: UINavigationController?
    static func createModule() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navigationController = storyboard.instantiateViewController(withIdentifier: "iTuneSearchNavigationController") as? UINavigationController else {
            fatalError("iTuneSearchNavigationController doesnt exist!")
        }
        guard let vc = navigationController.viewControllers.first as? iTuneSearchViewController else {
            fatalError("iTuneSearchViewController doesnt exist!")
        }
        let presenter  = iTuneSearchPresenter()
        let interactor = iTuneSearchInteractor()
        let router = iTuneSearchRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc
        interactor.presenter = presenter
        vc.presenter = presenter
        
        router.navigationController = navigationController
        return navigationController
    }
    
    func showPlayTrack(player:AVPlayer) {
        let playerViewController = AVPlayerViewController()
        playerViewController.entersFullScreenWhenPlaybackBegins = true
        playerViewController.exitsFullScreenWhenPlaybackEnds = true
        self.navigationController?.visibleViewController?.present(playerViewController, animated: true, completion: nil)
        playerViewController.player = player
        player.play()
    }
}
