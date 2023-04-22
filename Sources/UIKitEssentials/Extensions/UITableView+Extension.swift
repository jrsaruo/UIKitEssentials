//
//  UITableView+Extension.swift
//  
//
//  Created by Yusaku Nishi on 2022/04/11.
//

import UIKit

extension UITableView {
    
    /// Deselects all selected rows, with an option to animate the deselection.
    ///
    /// Calling this method doesn’t cause the delegate to receive a `tableView(_:willDeselectRowAt:)` or `tableView(_:didDeselectRowAt:)` message,
    /// nor does it send `selectionDidChangeNotification` notifications to observers.
    ///
    /// Calling this method doesn’t cause any scrolling to deselected rows.
    ///
    /// - Parameter animated: `true` if you want to animate the deselection, and `false` if the change should be immediate.
    public func deselectSelectedRows(animated: Bool) {
        guard let indexPathsForSelectedRows else { return }
        for indexPathForSelectedRow in indexPathsForSelectedRows {
            deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }
    
    /// Deselects all selected rows using the transition coordinator.
    ///
    /// Calling this method doesn’t cause the delegate to receive a `tableView(_:willDeselectRowAt:)` or `tableView(_:didDeselectRowAt:)` message,
    /// nor does it send `selectionDidChangeNotification` notifications to observers.
    ///
    /// Calling this method doesn’t cause any scrolling to deselected rows.
    ///
    /// Typically, you can use this method in `viewWillAppear` of the view controller:
    ///
    /// ```
    /// class ViewController: UIViewController {
    ///
    ///     override func viewWillAppear(_ animated: Bool) {
    ///         super.viewWillAppear(animated)
    ///
    ///         tableView.deselectSelectedRows(with: transitionCoordinator,
    ///                                        animated: animated)
    ///     }
    /// }
    /// ```
    ///
    /// If the animation is cancelled, rows will be reselected.
    ///
    /// - Parameters:
    ///   - transitionCoordinator: A transition coordinator used to animate the deselection.
    ///                            If `nil`, the deselection will be done with normal animation.
    ///   - animated: `true` if you want to animate the deselection, and `false` if the change should be immediate.
    public func deselectSelectedRows(with transitionCoordinator: UIViewControllerTransitionCoordinator?,
                                     animated: Bool) {
        guard let indexPathsForSelectedRows else { return }
        guard let transitionCoordinator, animated else {
            deselectSelectedRows(animated: animated)
            return
        }
        transitionCoordinator.animate(alongsideTransition: { [weak self] _ in
            self?.deselectSelectedRows(animated: animated)
        }, completion: { [weak self] context in
            guard let self else { return }
            if context.isCancelled {
                // Reselect rows
                for indexPathForSelectedRow in indexPathsForSelectedRows {
                    self.selectRow(at: indexPathForSelectedRow, animated: animated, scrollPosition: .none)
                }
            }
        })
    }
    
    /// Deselects the selected row using the transition coordinator.
    ///
    /// Calling this method doesn’t cause the delegate to receive a `tableView(_:willDeselectRowAt:)` or `tableView(_:didDeselectRowAt:)` message,
    /// nor does it send `selectionDidChangeNotification` notifications to observers.
    ///
    /// Calling this method doesn’t cause any scrolling to the deselected row.
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
    @available(*, deprecated, message: "Use deselectSelectedRows(with:animated:) instead.")
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
