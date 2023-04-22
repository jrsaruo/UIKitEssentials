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
    
    /// Transitions to the specified view controller.
    ///
    /// The source view controller instance will be destroyed.
    /// - Parameters:
    ///   - destinationVC: The view controller to transition to.
    ///   - animated: If `true`, the transition will be animated with a cross dissolve.
    ///   - completion: A closure to execute at the end of the transition.
    ///                 This closure has no return value and takes a single `Bool` argument that indicates whether or not the transition actually finished.
    public func transition(to destinationVC: UIViewController,
                           animated: Bool,
                           completion: ((_ completed: Bool) -> Void)? = nil) {
        assert(children.count <= 1)
        if let currentChild = children.first {
            currentChild.willMove(toParent: nil)
            currentChild.view.removeFromSuperview()
            currentChild.removeFromParent()
        }
        
        addChild(destinationVC)
        view.addSubview(destinationVC.view)
        destinationVC.view.frame = view.bounds
        
        func finishTransition(completed: Bool) {
            if completed {
                destinationVC.didMove(toParent: self)
                
                #if os(iOS)
                setNeedsUpdateOfHomeIndicatorAutoHidden()
                setNeedsUpdateOfScreenEdgesDeferringSystemGestures()
                setNeedsStatusBarAppearanceUpdate()
                if #available(iOS 14.0, *) {
                    setNeedsUpdateOfPrefersPointerLocked()
                }
                #endif
            }
            completion?(completed)
        }
        
        if animated {
            UIView.transition(with: view,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil) { completed in
                finishTransition(completed: completed)
            }
        } else {
            finishTransition(completed: true)
        }
    }
}

#if os(iOS)
extension RootViewController {
    
    public override var childForStatusBarHidden: UIViewController? {
        children.last
    }
    
    public override var childForStatusBarStyle: UIViewController? {
        children.last
    }
    
    public override var childForHomeIndicatorAutoHidden: UIViewController? {
        children.last
    }
    
    public override var childForScreenEdgesDeferringSystemGestures: UIViewController? {
        children.last
    }
    
    public override var childViewControllerForPointerLock: UIViewController? {
        children.last
    }
}
#endif

extension UIViewController {
    
    /// The root view controller for the current window.
    public var root: RootViewController {
        guard let window = view.window else {
            guard let root = parent?.root else {
                preconditionFailure("The view must be added to a window.")
            }
            return root
        }
        guard let root = window.rootViewController as? RootViewController else {
            preconditionFailure("The root view controller should be '\(RootViewController.self)'")
        }
        return root
    }
}
