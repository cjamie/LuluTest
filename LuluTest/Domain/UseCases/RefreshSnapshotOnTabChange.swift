//
//  RefreshSnapshotOnTabChange.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import Combine

final class RefreshSnapshotOnTabChange: UseCase {
    private let snapshotApplicable: SnapshotApplicable
    private let tabMode: AnyPublisher<BinaryTabbedController.Mode, Never>
    private var cancellable: AnyCancellable?
    private let latestGarments: AnyPublisher<[Garment], Never>

    init(
        snapshotApplicable: SnapshotApplicable,
        tabMode: AnyPublisher<BinaryTabbedController.Mode, Never>,
        latestGarments: AnyPublisher<[Garment], Never>
    ) {
        self.snapshotApplicable = snapshotApplicable
        self.tabMode = tabMode
        self.latestGarments = latestGarments
    }
    
    func start() {
        cancellable = Publishers
            .CombineLatest(tabMode, latestGarments)
            .map(ModeToSnapshotMapper.map)
            .sink { [weak self] in
                self?.snapshotApplicable.apply(snapshot: $0)
            }
    }
}

