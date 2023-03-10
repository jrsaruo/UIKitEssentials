//
//  NSCollectionLayoutSize+Extension.swift
//  
//
//  Created by Yusaku Nishi on 2022/10/02.
//

import UIKit

@available(iOS 13, tvOS 13, *)
extension NSCollectionLayoutSize {
    
    /// Creates a size that fills the containing group.
    public static var full: Self {
        .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    }
    
    /// Creates a size that is computed as a fraction of the width and height of the containing group.
    public static func fractional(width: CGFloat, height: CGFloat) -> Self {
        .init(widthDimension: .fractionalWidth(width), heightDimension: .fractionalHeight(height))
    }
    
    /// Creates a size with estimated point values.
    ///
    /// The final size is determined when the content is rendered.
    public static func estimated(width: CGFloat, height: CGFloat) -> Self {
        .init(widthDimension: .estimated(width), heightDimension: .estimated(height))
    }
    
    /// Creates a size with absolute point values.
    public static func absolute(width: CGFloat, height: CGFloat) -> Self {
        .init(widthDimension: .absolute(width), heightDimension: .absolute(height))
    }
}
