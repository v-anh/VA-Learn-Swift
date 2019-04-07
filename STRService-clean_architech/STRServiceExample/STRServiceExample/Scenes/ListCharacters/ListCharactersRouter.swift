//
//  ListCharactersRouter.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/18/19.
//

import UIKit

struct ListCharactersRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension ListCharactersRouter: ListCharactersRoutable {
    
    func showCharacterWith(name: String) {
        show(storyboard: .showCharacter) { (controller: ShowCharacterViewController) in
            controller.characterName = name
        }
    }
}
