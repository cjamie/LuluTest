//
//  HomeScreenComposer.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import UIKit
import Combine

final class HomeScreenComposer {
    static func compose(
        onAddTapped: @escaping () -> Void
    ) -> UIViewController {
        let bar = UIBarButtonItemController(onAddTapped: onAddTapped)
        let tabChanged = CurrentValueSubject<BinaryTabbedController.Mode, Never>(.primary)
        let garmentList = GarmentListController()
        
        // NOTE: - this is alternative to latestGarments in the use case
//        let garments = InMemoryGarments()
        
        let useCase = RefreshSnapshotOnTabChange(
            snapshotApplicable: garmentList,
            tabMode: tabChanged.removeDuplicates().eraseToAnyPublisher(),
            latestGarments: UserDefaults
                .standard
                .publisher(for: \.garments)
                .compactMap { $0 }
                .decode(
                    type: [UserDefaultsGarment].self,
                    decoder: JSONDecoder()
                )
                .map(\.toDomain)
                .catch { _ in Just([]) }
                .eraseToAnyPublisher()
        )
        
        let viewController = ViewController(
            bar: bar,
            tab: .init(
                model: .init(
                    primaryTitle: "{Alpha}",
                    secondaryTitle: "{Creation time}"
                ),
                selection: tabChanged
            ),
            garmentList: garmentList,
            onViewDidLoad: useCase
        )
        
        viewController.navigationItem.rightBarButtonItem = bar.view
        return viewController
    }
}
