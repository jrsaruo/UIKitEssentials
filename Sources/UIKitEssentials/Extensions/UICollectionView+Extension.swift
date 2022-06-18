//
//  UICollectionView+Extension.swift
//  
//
//  Created by Yusaku Nishi on 2022/06/18.
//

import UIKit

extension UICollectionView {
    
    /// Deselects the selected items using the transition coordinator.
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
        guard let indexPathsForSelectedItems = indexPathsForSelectedItems else { return }
        func deselectSelectedItems() {
            for indexPathForSelectedItem in indexPathsForSelectedItems {
                deselectItem(at: indexPathForSelectedItem, animated: animated)
            }
        }
        guard let transitionCoordinator = transitionCoordinator else {
            deselectSelectedItems()
            return
        }
        transitionCoordinator.animate(alongsideTransition: { _ in
            deselectSelectedItems()
        }, completion: { [weak self] context in
            if context.isCancelled {
                for indexPathForSelectedItem in indexPathsForSelectedItems {
                    self?.selectItem(at: indexPathForSelectedItem, animated: animated, scrollPosition: [])
                }
            }
        })
    }
}
