//
//  Routable.swift
//  
//
//  Created by Amine Bensalah on 23/09/2021.
//

#if canImport(UIKit)
import UIKit

protocol Routable {
    associatedtype StoryboardIdentifier: RawRepresentable
    
    func present<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: String?, bundle: Bundle?, animated: Bool, modalPresentationStyle: UIModalPresentationStyle?, configure: ((T) -> Void)?, completion: ((T) -> Void)?)
    func show<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: String?, bundle: Bundle?, configure: ((T) -> Void)?)
    func showDetailViewController<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: String?, bundle: Bundle?, configure: ((T) -> Void)?)
}

extension Routable where Self: UIViewController, StoryboardIdentifier.RawValue == String {
    
    /**
     Presents the intial view controller of the specified storyboard modally.
     
     - parameter storyboard: Storyboard name.
     - parameter identifier: View controller name.
     - parameter configure: Configure the view controller before it is loaded.
     - parameter completion: Completion the view controller after it is loaded.
     */
    func present<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: String? = nil, bundle: Bundle? = nil, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle? = nil, configure: ((T) -> Void)? = nil, completion: ((T) -> Void)? = nil) {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: bundle)
        
        guard let controller = (identifier != nil
                                    ? storyboard.instantiateViewController(withIdentifier: identifier!)
                                    : storyboard.instantiateInitialViewController()) as? T
        else { return assertionFailure("Invalid controller for storyboard \(storyboard).") }
        
        if let modalPresentationStyle = modalPresentationStyle {
            controller.modalPresentationStyle = modalPresentationStyle
        }
        
        configure?(controller)
        
        present(controller, animated: animated) {
            completion?(controller)
        }
    }
    
    /**
     Present the intial view controller of the specified storyboard in the primary context.
     Set the initial view controller in the target storyboard or specify the identifier.
     
     - parameter storyboard: Storyboard name.
     - parameter identifier: View controller name.
     - parameter configure: Configure the view controller before it is loaded.
     */
    func show<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: String? = nil, bundle: Bundle? = nil, configure: ((T) -> Void)? = nil) {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: bundle)
        
        guard let controller = (identifier != nil
                                    ? storyboard.instantiateViewController(withIdentifier: identifier!)
                                    : storyboard.instantiateInitialViewController()) as? T
        else { return assertionFailure("Invalid controller for storyboard \(storyboard).") }
        
        configure?(controller)
        
        show(controller, sender: self)
    }
    
    /**
     Present the intial view controller of the specified storyboard in the secondary (or detail) context.
     Set the initial view controller in the target storyboard or specify the identifier.
     
     - parameter storyboard: Storyboard name.
     - parameter identifier: View controller name.
     - parameter configure: Configure the view controller before it is loaded.
     */
    func showDetailViewController<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: String? = nil, bundle: Bundle? = nil,  configure: ((T) -> Void)? = nil) {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: bundle)
        
        guard let controller = (identifier != nil
                                    ? storyboard.instantiateViewController(withIdentifier: identifier!)
                                    : storyboard.instantiateInitialViewController()) as? T
        else { return assertionFailure("Invalid controller for storyboard \(storyboard).") }
        
        configure?(controller)
        
        showDetailViewController(controller, sender: self)
    }
}
#endif
