//
//  ViewController.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import UIKit

final class ViewController: UIViewController {
    private let bar: UIBarButtonItemController
    private let tab: BinaryTabbedController
    private let garmentList: GarmentListController
    private let onViewDidLoad: UseCase

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this should be injected
        self.title = "{List}"
        self.navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .systemCyan
        setupUI()
        onViewDidLoad.start()
        
    }
    
    private func setupUI() {
        view.addSubviews(tabView, garmentView)

        tabView.translatesAutoresizingMaskIntoConstraints = false
        garmentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tabView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            garmentView.topAnchor.constraint(equalTo: tabView.bottomAnchor),

            garmentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            garmentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            garmentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    init(
        bar: UIBarButtonItemController,
        tab: BinaryTabbedController,
        garmentList: GarmentListController,
        onViewDidLoad: UseCase
    ) {
        self.bar = bar
        self.tab = tab
        self.garmentList = garmentList
        self.onViewDidLoad = onViewDidLoad
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private var tabView: UIView {
        tab.view
    }

    private var garmentView: UIView {
        garmentList.view
    }
}

