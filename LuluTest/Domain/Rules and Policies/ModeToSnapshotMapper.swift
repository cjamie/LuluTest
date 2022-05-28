//
//  ModeToSnapshotMapper.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import Foundation

enum ModeToSnapshotMapper {
    static func map(from: (
        BinaryTabbedController.Mode,
        [Garment]
    )) -> GarmentListController.Snapshot {
        let (mode, latestGarments) = from
        let items = latestGarments.sorted(by: ModeToPredicate.map(mode)).map(\.name)

        var snap = GarmentListController.Snapshot()
        snap.appendSections([1])
        snap.appendItems(items, toSection: 1)
        return snap
    }
}

enum ModeToPredicate {
    static func map(_ mode: BinaryTabbedController.Mode) -> (Garment, Garment) -> Bool {
        { lhs, rhs in
            switch mode {
            case .primary:
                return lhs.name < rhs.name
            case .secondary:
                return lhs.creationTime < rhs.creationTime
            }
        }
    }
}
