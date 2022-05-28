//
//  Coordinator.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
