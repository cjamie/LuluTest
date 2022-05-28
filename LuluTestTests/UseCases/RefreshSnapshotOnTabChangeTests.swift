//
//  RefreshSnapshotOnTabChangeTests.swift
//  LuluTestTests
//
//  Created by Jamie Chu on 5/28/22.
//

@testable import LuluTest
import XCTest
import Combine

final class RefreshSnapshotOnTabChangeTests: XCTestCase {
    func test_start() throws {
        let one = Garment(name: "one", creationTime: .init())
        
        let spy = SnapshotApplicableSpy()
        let sut = RefreshSnapshotOnTabChange(
            snapshotApplicable: spy,
            tabMode: Just(.primary).eraseToAnyPublisher(),
            latestGarments: Just([ one ]).eraseToAnyPublisher()
        )
        
        
        sut.start()
        
        let firstApply = try XCTUnwrap(spy.calledApply.first)
        
        XCTAssertEqual(spy.calledApply.count, 1)
        XCTAssertEqual(
            firstApply.sectionIdentifiers,
            [1]
        )
        XCTAssertEqual(
            firstApply.itemIdentifiers(inSection: 1),
            [ one.name ]
        )
    }
}

final class SnapshotApplicableSpy: SnapshotApplicable {
    private(set) var calledApply: [GarmentListController.Snapshot] = []

    func apply(snapshot: GarmentListController.Snapshot) {
        calledApply.append(snapshot)
    }
}

extension Garment: Equatable {
    public static func == (lhs: Garment, rhs: Garment) -> Bool {
        lhs.name == rhs.name && lhs.creationTime == rhs.creationTime
    }
}
