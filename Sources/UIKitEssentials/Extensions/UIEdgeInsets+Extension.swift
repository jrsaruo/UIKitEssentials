//
//  UIEdgeInsets+Extension.swift
//  
//
//  Created by Yusaku Nishi on 2022/08/05.
//

import UIKit

extension UIEdgeInsets {
    
    /// Creates an edge insets structure.
    /// - Parameters:
    ///   - vertical: Insets on the top and the bottom of an object.
    ///   - horizontal: Insets on the left and the right of an object.
    @inlinable
    public init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
