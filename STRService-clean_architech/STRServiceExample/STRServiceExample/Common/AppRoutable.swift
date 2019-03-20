import UIKit

protocol AppRoutable: Router {
    var viewController: UIViewController? { get set }
    func dismiss()
}

// MARK: - Helper functions

extension AppRoutable {
    
    func present<T: UIViewController>(storyboard: Storyboard, identifier: String? = nil, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle? = nil, modalTransitionStyle: UIModalTransitionStyle? = nil, configure: ((T) -> Void)? = nil, completion: ((T) -> Void)? = nil) {
        present(storyboard: storyboard.rawValue, identifier: identifier, animated: animated, modalPresentationStyle: modalPresentationStyle, modalTransitionStyle: modalTransitionStyle, configure: configure, completion: completion)
    }
    
    func show<T: UIViewController>(storyboard: Storyboard, identifier: String? = nil, configure: ((T) -> Void)? = nil) {
        show(storyboard: storyboard.rawValue, identifier: identifier, configure: configure)
    }
    
    func dismiss() {
        guard let navController = viewController?.navigationController else {
            viewController?.dismiss(animated: true)
            return
        }
        
        guard navController.viewControllers.count > 1 else {
            return navController.dismiss(animated: true)
        }
        
        navController.popViewController(animated: true)
    }
}

// MARK: - Storyboard identifiers for routing

enum Storyboard: String {
    case listCharacters = "ListCharacters"
    case showCharacter = "ShowCharacter"
}
