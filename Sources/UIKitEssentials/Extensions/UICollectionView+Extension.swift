//
//  UICollectionView+Extension.swift
//  
//
//  Created by Yusaku Nishi on 2022/06/18.
//

import UIKit

extension UICollectionView {
    
    /// Deselects all selected items.
    ///
    /// If the `allowsSelection` property is `false`, calling this method has no effect.
    /// This method does not cause any selection-related delegate methods to be called.
    ///
    /// - Parameter animated: Specify `true` to animate the change in the selection or `false` to make the change without animating it.
    public func deselectSelectedItems(animated: Bool) {
        guard let indexPathsForSelectedItems else { return }
        for indexPathForSelectedItem in indexPathsForSelectedItems {
            deselectItem(at: indexPathForSelectedItem, animated: animated)
        }
    }
    
    /// Deselects all selected items using the transition coordinator.
    ///
    /// If the `allowsSelection` property is `false`, calling this method has no effect.
    /// This method does not cause any selection-related delegate methods to be called.
    ///
    /// Typically, you can use this method in `viewWillAppear` of the view controller:
    ///
    /// ```
    /// class ViewController: UIViewController {
    ///
    ///     override func viewWillAppear(_ animated: Bool) {
    ///         super.viewWillAppear(animated)
    ///
    ///         collectionView.deselectSelectedItems(with: transitionCoordinator,
    ///                                              animated: animated)
    ///     }
    /// }
    /// ```
    ///
    /// If the animation is cancelled, items will be reselected.
    ///
    /// - Parameters:
    ///   - transitionCoordinator: A transition coordinator used to animate the deselection.
    ///                            If `nil`, the deselection will be done with normal animation.
    ///   - animated: `true` if you want to animate the deselection, and `false` if the change should be immediate.
    public func deselectSelectedItems(with transitionCoordinator: UIViewControllerTransitionCoordinator?,
                                      animated: Bool) {
        guard let indexPathsForSelectedItems else { return }
        guard let transitionCoordinator, animated else {
            deselectSelectedItems(animated: animated)
            return
        }
        transitionCoordinator.animate(alongsideTransition: { [weak self] _ in
            self?.deselectSelectedItems(animated: animated)
        }, completion: { [weak self] context in
            guard let self else { return }
            if context.isCancelled {
                // Reselect items
                for indexPathForSelectedItem in indexPathsForSelectedItems {
                    self.selectItem(at: indexPathForSelectedItem, animated: animated, scrollPosition: [])
                }
            }
        })
    }
}
