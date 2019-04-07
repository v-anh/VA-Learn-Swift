//
//  ShowCharacterRouter.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/19/19.
//

import UIKit

struct ShowCharacterRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension ShowCharacterRouter: ShowCharacterRoutable {

}
