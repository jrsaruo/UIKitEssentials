//
//  UIEdgeInsetsExtensionTests.swift
//  
//
//  Created by Yusaku Nishi on 2022/08/05.
//

import XCTest
import UIKitEssentials

final class UIEdgeInsetsExtensionTests: XCTestCase {
    
    func testInit() {
        XCTAssertEqual(
            UIEdgeInsets(vertical: 8, horizontal: 16),
            UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        )
    }
}
