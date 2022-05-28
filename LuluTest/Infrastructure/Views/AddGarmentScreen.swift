//
//  AddGarmentScreen.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import UIKit
import Combine

final class AddGarmentScreen: UIViewController {
    private lazy var bar = UIBarButtonItem(
        title: model.rightBanner,
        style: .plain,
        target: self,
        action: #selector(didTapSave)
    )
    
    private let label = UILabel().then { $0.backgroundColor = .systemTeal }
    private let textField: UITextField
    private let model: Model
    var userDidTapSave: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = model.title
        navigationItem.rightBarButtonItem = bar
        
        let stack = UIStackView(arrangedSubviews: [label, textField])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        label.text = model.headline
    }

    private var cancellable: AnyCancellable?
    
    struct Model {
        let title: String
        let headline: String
        let rightBanner: String
    }

    init(model: Model, textField: UITextField) {
        self.model = model
        self.textField = textField
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTapSave() {
        dismiss(animated: true, completion: userDidTapSave)
    }
}

