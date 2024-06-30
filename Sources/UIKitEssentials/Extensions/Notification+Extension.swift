//
//  Notification+Extension.swift
//  
//
//  Created by Yusaku Nishi on 2022/06/06.
//

import UIKit

@available(tvOS, unavailable)
extension Notification {
    
    /// The keyboard’s frame at the end of its animation.
    @inlinable
    public var keyboardFrameEnd: CGRect? {
        userInfo?[UIView.keyboardFrameEndUserInfoKey] as? CGRect
    }
    
    /// The duration of the keyboard animation in seconds.
    @inlinable
    public var keyboardAnimationDuration: TimeInterval? {
        userInfo?[UIView.keyboardAnimationDurationUserInfoKey] as? TimeInterval
    }
    
    /// The animation curve that the system uses to animate the keyboard onto or off the screen.
    @inlinable
    public var keyboardAnimationCurve: UIView.AnimationCurve? {
        guard let animationCurveValue = userInfo?[UIView.keyboardAnimationCurveUserInfoKey] as? Int else {
            return nil
        }
        return .init(rawValue: animationCurveValue)
    }
    
    /// Options the system uses to animate the keyboard onto or off the screen.
    @inlinable
    public var keyboardAnimationOptions: UIView.AnimationOptions? {
        guard let animationCurveValue = userInfo?[UIView.keyboardAnimationCurveUserInfoKey] as? UInt else {
            return nil
        }
        return .init(rawValue: animationCurveValue)
    }
}
