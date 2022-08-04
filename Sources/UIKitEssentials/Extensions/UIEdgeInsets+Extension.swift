//
//  UIEdgeInsets+Extension.swift
//  
//
//  Created by Yusaku Nishi on 2022/08/05.
//

import UIKit

extension UIEdgeInsets {
    
    @inlinable
    public init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
