//
//  UITableView+Extension.swift
//  
//
//  Created by Yusaku Nishi on 2022/04/11.
//

import UIKit

extension UITableView {
    
    /// Deselects the selected row using the transition coordinator.
    ///
    /// Typically, you can use this method in `viewWillAppear` of the view controller:
    ///
    /// ```
    /// class ViewController: UIViewController {
    ///
    ///     override func viewWillAppear(_ animated: Bool) {
    ///         super.viewWillAppear(animated)
    ///
    ///         tableView.deselectSelectedRow(with: transitionCoordinator,
    ///                                       animated: animated)
    ///     }
    /// }
    /// ```
    ///
    /// If the animation is cancelled, the row will be reselected.
    ///
    /// - Parameters:
    ///   - transitionCoordinator: A transition coordinator used to animate the deselection.
    ///                            If `nil`, the deselection will be done with normal animation.
    ///   - animated: `true` if you want to animate the deselection, and `false` if the change should be immediate.
    public func deselectSelectedRow(with transitionCoordinator: UIViewControllerTransitionCoordinator?,
                                    animated: Bool) {
        guard let indexPathForSelectedRow = indexPathForSelectedRow else { return }
        guard let transitionCoordinator = transitionCoordinator else {
            deselectRow(at: indexPathForSelectedRow, animated: animated)
            return
        }
        transitionCoordinator.animate(alongsideTransition: { [weak self] _ in
            self?.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }, completion: { [weak self] context in
            if context.isCancelled {
                self?.selectRow(at: indexPathForSelectedRow, animated: animated, scrollPosition: .none)
            }
        })
    }
}
