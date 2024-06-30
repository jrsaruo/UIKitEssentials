//
//  RootViewControllerTests.swift
//  
//
//  Created by Yusaku Nishi on 2022/04/14.
//

import XCTest
import UIKitEssentials

class RootViewControllerTests: XCTestCase {
    
    final class ViewController: UIViewController {
        
        private(set) var viewWillAppearCalledCount = 0
        private(set) var viewDidAppearCalledCount = 0
        private(set) var viewWillDisappearCalledCount = 0
        private(set) var viewDidDisappearCalledCount = 0
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            viewWillAppearCalledCount += 1
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            viewDidAppearCalledCount += 1
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            viewWillDisappearCalledCount += 1
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            viewDidDisappearCalledCount += 1
        }
    }
    
    private var rootVC: RootViewController!
    private var childVC: ViewController!
    
    override func setUp() {
        rootVC = RootViewController()
        
        let window = UIWindow()
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        
        childVC = ViewController()
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
    
    func testTransition_viewHierarchy() {
        XCTAssertEqual(rootVC.view.subviews, [childVC.view])
        
        let destinationVC = UIViewController()
        let completionCalled = expectation(description: "Completion handler should be called.")
        rootVC.transition(to: destinationVC, animated: false) { _ in
            completionCalled.fulfill()
        }
        wait(for: [completionCalled], timeout: 0.1)
        XCTAssertEqual(rootVC.view.subviews, [destinationVC.view])
    }
    
    func testTransition_lifecycle() {
        // Arrange
        let destinationVC = ViewController()
        let transitionDidComplete = expectation(
            description: "The transition completed."
        )
        
        // Act
        rootVC.transition(to: destinationVC, animated: true) { _ in
            transitionDidComplete.fulfill()
        }
        
        // Assert
        XCTAssertEqual(childVC.viewWillDisappearCalledCount, 1)
        XCTAssertEqual(childVC.viewDidDisappearCalledCount, 0)
        XCTAssertEqual(destinationVC.viewWillAppearCalledCount, 1)
        XCTAssertEqual(destinationVC.viewDidAppearCalledCount, 0)
        
        wait(for: [transitionDidComplete])
        
        XCTAssertEqual(childVC.viewWillDisappearCalledCount, 1)
        XCTAssertEqual(childVC.viewDidDisappearCalledCount, 1)
        XCTAssertEqual(destinationVC.viewWillAppearCalledCount, 1)
        XCTAssertEqual(destinationVC.viewDidAppearCalledCount, 1)
    }
}
