//
//  Routable.swift
//  STRServiceExample
//
//  Created by Ngo Chi Hai on 3/18/19.
//

import UIKit

public protocol Router {
    var viewController: UIViewController? { get set }
    
    func present<T: UIViewController>(storyboard: String, identifier: String?, animated: Bool, modalPresentationStyle: UIModalPresentationStyle?, modalTransitionStyle: UIModalTransitionStyle?, configure: ((T) -> Void)?, completion: ((T) -> Void)?)
    func show<T: UIViewController>(storyboard: String, identifier: String?, configure: ((T) -> Void)?)
    func showDetailViewController<T: UIViewController>(storyboard: String, identifier: String?, configure: ((T) -> Void)?)
}

public extension Router {
    
    /**
     Presents the intial view controller of the specified storyboard modally.
     
     - parameter storyboard: Storyboard name.
     - parameter identifier: View controller name.
     - parameter configure: Configure the view controller before it is loaded.
     - parameter completion: Completion the view controller after it is loaded.
     */
    func present<T: UIViewController>(storyboard: String, identifier: String? = nil, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle? = nil, modalTransitionStyle: UIModalTransitionStyle? = nil, configure: ((T) -> Void)? = nil, completion: ((T) -> Void)? = nil) {
        guard let viewController = viewController else { return }
        RoutingLogic.present(delegate: viewController, storyboard: storyboard, identifier: identifier, animated: animated, modalPresentationStyle: modalPresentationStyle, modalTransitionStyle: modalTransitionStyle, configure: configure, completion: completion)
    }
    
    /**
     Present the intial view controller of the specified storyboard in the primary context.
     Set the initial view controller in the target storyboard or specify the identifier.
     
     - parameter storyboard: Storyboard name.
     - parameter identifier: View controller name.
     - parameter configure: Configure the view controller before it is loaded.
     */
    func show<T: UIViewController>(storyboard: String, identifier: String? = nil, configure: ((T) -> Void)? = nil) {
        guard let viewController = viewController else { return }
        RoutingLogic.show(delegate: viewController, storyboard: storyboard, identifier: identifier, configure: configure)
    }
    
    /**
     Present the intial view controller of the specified storyboard in the secondary (or detail) context.
     Set the initial view controller in the target storyboard or specify the identifier.
     
     - parameter storyboard: Storyboard name.
     - parameter identifier: View controller name.
     - parameter configure: Configure the view controller before it is loaded.
     */
    func showDetailViewController<T: UIViewController>(storyboard: String, identifier: String? = nil, configure: ((T) -> Void)? = nil) {
        guard let viewController = viewController else { return }
        RoutingLogic.showDetailViewController(delegate: viewController, storyboard: storyboard, identifier: identifier, configure: configure)
    }
}

// MARK: - Private functions

fileprivate enum RoutingLogic {
    
    static func present<T: UIViewController>(delegate: UIViewController, storyboard: String, identifier: String? = nil, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle? = nil, modalTransitionStyle: UIModalTransitionStyle? = nil, configure: ((T) -> Void)? = nil, completion: ((T) -> Void)? = nil) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        guard let controller = (identifier != nil
            ? storyboard.instantiateViewController(withIdentifier: identifier!)
            : storyboard.instantiateInitialViewController()) as? T
            else { return assertionFailure("Invalid controller for storyboard \(storyboard).") }
        
        if let modalPresentationStyle = modalPresentationStyle {
            controller.modalPresentationStyle = modalPresentationStyle
        }
        
        if let modalTransitionStyle = modalTransitionStyle {
            controller.modalTransitionStyle = modalTransitionStyle
        }
        
        configure?(controller)
        
        delegate.present(controller, animated: animated) {
            completion?(controller)
        }
    }
    
    static func show<T: UIViewController>(delegate: UIViewController, storyboard: String, identifier: String? = nil, configure: ((T) -> Void)? = nil) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        guard let controller = (identifier != nil
            ? storyboard.instantiateViewController(withIdentifier: identifier!)
            : storyboard.instantiateInitialViewController()) as? T
            else { return assertionFailure("Invalid controller for storyboard \(storyboard).") }
        
        configure?(controller)
        
        delegate.show(controller, sender: delegate)
    }
    
    static func showDetailViewController<T: UIViewController>(delegate: UIViewController, storyboard: String, identifier: String? = nil, configure: ((T) -> Void)? = nil) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        guard let controller = (identifier != nil
            ? storyboard.instantiateViewController(withIdentifier: identifier!)
            : storyboard.instantiateInitialViewController()) as? T
            else { return assertionFailure("Invalid controller for storyboard \(storyboard).") }
        
        configure?(controller)
        
        delegate.showDetailViewController(controller, sender: delegate)
    }
}
