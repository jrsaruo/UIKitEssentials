//
//  RootViewControllerTests.swift
//  
//
//  Created by Yusaku Nishi on 2022/04/14.
//

import XCTest
import UIKitEssentials

class RootViewControllerTests: XCTestCase {
    
    func testUIViewControllerRoot() {
        let rootVC = RootViewController()
        let window = UIWindow()
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        
        let viewController = UIViewController()
        rootVC.transition(to: viewController, animated: false)
        XCTAssertEqual(viewController.root, rootVC)
    }
}
