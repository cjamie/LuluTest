//
//  GarmentListController.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import UIKit

protocol SnapshotApplicable {
    func apply(snapshot: GarmentListController.Snapshot)
}

final class GarmentListController: SnapshotApplicable {
    // Note: this happens to only need a string so a typealias is enough
    typealias PresentableGarment = String
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, PresentableGarment>
    typealias DataSource = UITableViewDiffableDataSource<Int, PresentableGarment>

    let view = UITableView().then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: Constants.someID)
    }
    
    private lazy var datasource = DataSource(
        tableView: view
    ) { tableView, _, garment in
        tableView
            .dequeueReusableCell(withIdentifier: Constants.someID)?
            .then {
                $0.textLabel?.text = garment
                $0.backgroundColor = .brown
            }
    }
    
    // MARK: - SnapshotApplicable
    
    func apply(snapshot: Snapshot) {
        datasource.apply(snapshot)
    }
    
    // MARK: - Helpers

    private enum Constants {
        static let someID = "someId"
    }
}
