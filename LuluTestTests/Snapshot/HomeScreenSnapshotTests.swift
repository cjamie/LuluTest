//
//  HomeScreenSnapshotTests.swift
//  LuluTestTests
//
//  Created by Jamie Chu on 5/28/22.
//

import XCTest
import SnapshotTesting
@testable import LuluTest

class HomeScreenSnapshotTests: XCTestCase {

    func test_one() {
        let vc = HomeScreenComposer.compose(onAddTapped: {})
        
//        assertSnapshot(matching: vc, as: .image, record: true)
//
//        // or globally
//
//        isRecording = true
        assertSnapshot(matching: vc, as: .image)
    }
}
