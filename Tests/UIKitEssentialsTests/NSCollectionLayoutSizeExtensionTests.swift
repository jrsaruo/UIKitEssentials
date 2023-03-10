//
//  NSCollectionLayoutSizeExtensionTests.swift
//  
//
//  Created by Yusaku Nishi on 2023/03/11.
//

import XCTest
@testable import UIKitEssentials

final class NSCollectionLayoutSizeExtensionTests: XCTestCase {
    
    func testCreationMethods() throws {
        guard #available(iOS 13, tvOS 13, *) else {
            throw XCTSkip("This test case requires")
        }
        XCTAssertEqual(
            NSCollectionLayoutSize.full,
            NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        XCTAssertEqual(
            NSCollectionLayoutSize.fractional(width: 0.3, height: 0.5),
            NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.3),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        XCTAssertEqual(
            NSCollectionLayoutSize.estimated(width: 100, height: 200),
            NSCollectionLayoutSize(
                widthDimension: .estimated(100),
                heightDimension: .estimated(200)
            )
        )
        XCTAssertEqual(
            NSCollectionLayoutSize.absolute(width: 300, height: 400),
            NSCollectionLayoutSize(
                widthDimension: .absolute(300),
                heightDimension: .absolute(400)
            )
        )
    }
}
