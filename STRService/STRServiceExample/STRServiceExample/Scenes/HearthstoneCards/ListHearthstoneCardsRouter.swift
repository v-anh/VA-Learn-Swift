//
//  ListHearthstoneCardsRouter.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/26/19.
//

import UIKit

struct ListHearthstoneCardsRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension ListHearthstoneCardsRouter: ListHearthstoneCardsRoutable {
    
    func showHearthstoneCardWith(name: String) {
        
    }
}
