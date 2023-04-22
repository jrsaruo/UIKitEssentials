//
//  RootViewControllerTests.swift
//  
//
//  Created by Yusaku Nishi on 2022/04/14.
//

import XCTest
import UIKitEssentials

class RootViewControllerTests: XCTestCase {
    
    private var rootVC: RootViewController!
    private var childVC: UIViewController!
    
    override func setUp() {
        rootVC = RootViewController()
        
        let window = UIWindow()
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        
        childVC = UIViewController()
        rootVC.transition(to: childVC, animated: false)
    }
    
    override func tearDown() {
        rootVC = nil
        childVC = nil
    }
    
    func testUIViewControllerRoot() {
        XCTAssertEqual(childVC.root, rootVC)
        
        let childVC2 = UIViewController()
        let navigationController = UINavigationController(rootViewController: childVC2)
        rootVC.transition(to: navigationController, animated: false)
        XCTAssertEqual(childVC2.root, rootVC)
        
        let childVC3 = UIViewController()
        navigationController.pushViewController(childVC3, animated: false)
        XCTAssertEqual(childVC2.root, rootVC)
    }
    
    func testTransition() {
        XCTAssertEqual(rootVC.view.subviews, [childVC.view])
        
        let destinationVC = UIViewController()
        let completionCalled = expectation(description: "Completion handler should be called.")
        rootVC.transition(to: destinationVC, animated: false) { _ in
            completionCalled.fulfill()
        }
        wait(for: [completionCalled], timeout: 0.1)
        XCTAssertEqual(rootVC.view.subviews, [destinationVC.view])
    }
}
