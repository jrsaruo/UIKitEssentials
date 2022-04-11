//
//  RootViewController.swift
//  
//
//  Created by Yusaku Nishi on 2022/04/11.
//

import UIKit

/// The root view controller for the application window.
///
/// This view controller allows cross-dissolve animation during transitions.
/// Use for `rootViewController` of the `UIWindow` and access it through `root` property of the view controller.
///
/// ```
/// class SomeViewController: UIViewController {
///    func moveToNext() {
///        root.transition(to: NextViewController(), animated: true)
///    }
/// }
/// ```
///
/// - Note: Do **NOT** call `addChild` of this view controller.
public final class RootViewController: UIViewController {
    
    // MARK: - Methods
    
    /// Transition to the specified view controller.
    ///
    /// The source view controller instance will be destroyed.
    /// - Parameters:
    ///   - destinationVC: The view controller to transition to.
    ///   - animated: If `true`, the transition will be animated with a cross dissolve.
    public func transition(to destinationVC: UIViewController, animated: Bool) {
        assert(children.count <= 1)
        if let currentChild = children.first {
            currentChild.willMove(toParent: nil)
            currentChild.view.removeFromSuperview()
            currentChild.removeFromParent()
        }
        
        addChild(destinationVC)
        view.addSubview(destinationVC.view)
        destinationVC.view.frame = view.bounds
        
        if animated {
            UIView.transition(with: view,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil) { completed in
                if completed {
                    destinationVC.didMove(toParent: self)
                }
            }
        } else {
            destinationVC.didMove(toParent: self)
        }
    }
}

extension UIViewController {
    
    /// The root view controller for the current window.
    public var root: RootViewController {
        guard let window = view.window else {
            preconditionFailure("The view should be added to a window.")
        }
        guard let root = window.rootViewController as? RootViewController else {
            preconditionFailure("The root view controller should be '\(RootViewController.self)'")
        }
        return root
    }
}
